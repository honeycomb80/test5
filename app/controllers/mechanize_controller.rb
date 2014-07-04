class MechanizeController < ApplicationController
require "nokogiri"
require "mechanize"
require "rubygems"
require "open-uri"


def get_article_data(pg = 2, article_date = Date.today)
  agent = Mechanize.new
  tc = agent.get('http://www.techcrunch.com')
  article_pg_count = 0

  until article_date === Date.today - 2
    # gets article date
    tc.root.css('li.river-block').each do |link|
      article_date = link.css('time')[0]['datetime']
      article_date = Date.parse(article_date)
    end
    tc.root.css('h2.post-title').each do |this|
      # gets the link
      @link  =  this.css('a')[0]['href']
      puts @link
      # gets the title
      title  =  this.css('a')[0].text
      puts title
      # creates the mechanize object to the article for scraping later
      m_link =  this.css('a')[0]
      url = Mechanize::Page::Link.new(m_link, agent, tc)
      # url = url.click <-- I can use this to change course, scrape articles while crawling
      article_pg_count += 1
      # clicks the next page of links
      if article_pg_count == 20
        tc = tc.link_with(:href => %r{page/#{pg}}i).click
        tc
        pg += 1
        puts pg
        article_pg_count = 0
      end
    end
  end
end


# text stripper, put in a URL for @link to make it happen
def strip_text(@link)
  s_agent = Mechanize.new
  tc_article = s_agent.get(@link)
  html_elem = tc_article.at('div.article-entry')
  case html_elem
  when html_elem.css('p').each do |t|
      @article_text = t.text.strip
      puts @article_text
    end
  end
end

# puts words into three word arrays, as phrases (for phrase searching)
def make_compound(array)
  array.each do |word|
    n = array.index(word)
    three_word_array = array[n..n+2]
  end
end