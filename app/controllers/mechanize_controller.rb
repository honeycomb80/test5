class MechanizeController < ApplicationController
require "nokogiri"
require "mechanize"
require "rubygems"
require "open-uri"


def get_articles(pg = 2, article_date = Date.today)
  agent = Mechanize.new
  tc = agent.get('http://www.techcrunch.com/')
  # there are 20 articles/page, this counts them
  article_pg_count = 0 

  # limit setter on pages/articles
  until article_date === Date.today - 2 
    tc.root.css('li.river-block').each do |link|
      # sometimes the link moves, this gets title & url regardless
      if link['data-permalink'].nil? 
        url = link.css('a')[0]['href']
        title = link.css('a')[0].text
      else
        url = link['data-permalink']
        title = link['data-sharetitle']
      end
      article_date = link.css('time')[0]['datetime']
      article_date = Date.parse(article_date)
      Article.create = (title: title, url: url, date: article_date)
      article_pg_count += 1
      # pp "Article: #{article_pg_count}"
      if article_pg_count == 20
        tc = tc.link_with(:href => %r{page/#{pg}}i).click
        tc
        pg += 1
        article_pg_count = 0
      end
    end
  end
end


agent = Mechanize.new
tc = agent.get('http://www.techcrunch.com')
article_pg_count = 0

tc.root.css('h2.post-title').take(1).each do |this|
  @link  =  this.css('a')[0]['href']
  title  =  this.css('a')[0].text
  m_link =  this.css('a')[0]
  url = Mechanize::Page::Link.new(m_link, agent, tc)
  url = url.click
  # pp url
  article_pg_count += 1
  puts "Article: #{article_pg_count}"
end


i = 0
s_agent = Mechanize.new
tc_article = s_agent.get(@link)
text_elem = tc_article.at('div.article-entry')
case text_elem
when text_elem.css('div').each do |t|
    print ""
  end
when text_elem.css('p').each do |t|
    pp t.text
  end
end