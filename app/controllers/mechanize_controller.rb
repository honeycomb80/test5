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
    # this gets the article date
    tc.root.css('li.river-block').each do |link|
      article_date = link.css('time')[0]['datetime']
      article_date = Date.parse(article_date)
    end
    tc.root.css('h2.post-title').each do |this|
      # this gets the link
      @link  =  this.css('a')[0]['href']
      puts @link
      # this gets the title
      title  =  this.css('a')[0].text
      puts title
      # this creates the mechanize object to the article for scraping later
      m_link =  this.css('a')[0]
      url = Mechanize::Page::Link.new(m_link, agent, tc)
      # url = url.click <-- I can use this to change course, scrape articles while crawling
      article_pg_count += 1
      # this gets me to the next page of links
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


# text stripper: I put in a URL for "link" to make it happen
def strip_text(link)
  s_agent = Mechanize.new
  tc_article = s_agent.get(link)
  html_elem = tc_article.at('div.article-entry')
  case html_elem
  when html_elem.css('p').each do |t|
      @article_text = t.text.strip
      puts @article_text
    end
  end
end

# these check fronts, backs of words for quotes
def fr_quotes(word)
  /\A\"|\'/.match(word) != nil
end

def bk_quotes(word)
  /\Z\"|\'/.match(word) != nil
end

# these check fronts, backs of word for parentheses
def fr_parens(word)
  /\A\(|\{|\</.match(word) != nil
end

def bk_parens(word)
  /\A\)|\}|\>/.match(word) != nil
end

# these check fronts, backs of words for other punctuation
def check_fr(word)
  /\A\,|\?|\!\+/.match(word) != nil
end

def check_bk(word)
  /\Z\,|\?|\!|\./.match(word) != nil
end

# this checks a two-word array for punctuation problems
def check_two(array)
  one   = array[0]
  two   = array[1]
  if bk_quotes(one) || bk_parens(one) || check_bk(one) || fr_parens(two) || fr_quotes(two)
    array.clear
  end
end

# this checks a three-word array for punctuation problems
def check_three(array)
  one   = array[0]
  two   = array[1]
  three = array[2]
  if bk_quotes(one) || bk_parens(one) || check_bk(one) || fr_parens(two) || fr_quotes(two)
    array.clear
  elsif bk_quotes(two) || bk_parens(two) || check_bk(two) || fr_parens(three) || fr_quotes(three)
    array.clear
  end
end

# this checks to see if it's google+
def plus(word)
  if /\Z+/.match(word).nil? == false
    if /google/i.match(word).nil? == false
      true
    end
  else
    false
  end
end

# this checks to see if it's a proper noun (to denote as brand)
def proper(word)
  /[[:upper:]]/.match(word).nil?
end

# this makes an array into smaller, 2 and 3 word arrays...
# ...then returns an array of these smaller arrays.
# It also checks them for punctuation and length problems.
def make_phrase(array)
  hold = []
  array.each do |word|
    n = array.index(word)
    # creates a two word array
    two_word = array[n..n+1]
    check_two(two_word)
    if two_word[1].nil?
      two_word.clear
    else
      hold << two_word
    end
    # creates a three word array
    three_word = array[n..n+2]
    check_three(three_word)
    if three_word[2].nil?
      three_word.clear
    else      
      hold << three_word
    end
  end

end