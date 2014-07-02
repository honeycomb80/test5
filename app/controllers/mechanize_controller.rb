class MechanizeController < ApplicationController
require "nokogiri"
require "mechanize"
require "rubygems"
require "open-uri"


# vvv 1. ARTICLE GETTER vvv
# vvv [to make ready, remove "take(1)"] vvv

# agent = Mechanize.new
# tc = agent.get('http://www.techcrunch.com')
# article_pg_count = 0
# pg = 2

# tc.root.css('h2.post-title').take(1).each do |this|
#   @link  =  this.css('a')[0]['href']
#   title  =  this.css('a')[0].text
#   m_link =  this.css('a')[0]
#   url = Mechanize::Page::Link.new(m_link, agent, tc)
#   url = url.click
#   article_pg_count += 1
#   puts "Article: #{article_pg_count}"


# vvv 2. NEXT PAGE GETTER (relies on 1: link, article_pg_count) vvv
# vvv [to prep, insert page scraping, parsing functions]

#   if article_pg_count == 20
#     tc = tc.link_with(:href => %r{page/#{pg}}i).click
#     tc
#     pg += 1
#     article_pg_count = 0
#   end
# end


# vvv 3. TEXT STRIPPER vvv (relies on 2: @link)
# vvv [to get ready, insert parsing function where "puts @article_text" is] vvv

# s_agent = Mechanize.new
# tc_article = s_agent.get(@link)
# html_elem = tc_article.at('div.article-entry')
# case html_elem
# when html_elem.css('p').each do |t|
#     @article_text = t.text.strip
#     puts @article_text
#   end
# end



# vvv 4. GETS ARTICLE DATE (relies on 1: link) vvv
# vvv [to prep, replace "pp article_date" with ActiveRecord code] vvv
  
  # tc.root.css('li.river-block').each do |link|
  #   article_date = link.css('time')[0]['datetime']
  #   article_date = Date.parse(article_date)
  #   pp article_date
  # end




# vvv 5. LIMITS ARTICLE GETS BY DATE vvv
# vvv [to prep, insert at top of function]

# def get_articles(pg = 2, article_date = Date.today)
#   ...
#   until article_date === Date.today - 2
#     tc.root.css('li.river-block')....
#       



# vvv TEST DATA vvv

# array = ['alpha', 'Bravo', 'charlie', 'Delta', 'Echo', 'foxtrot', 'golf', '500',
#   'Hotel', 'Igloo', 'Juliet', 'Kilo', '10,000', 'a', 'target', 'window', 'of',
#   '“sometime', 'in', 'July”.', 'Word', 'on', 'the', 'Oculus', 'fan', 'forums',
#   '(Developer', 'Kit', '#2', '45,000+', 'pre-orders', 'while:', 'while', 'DK2',
#   '10,000', 'second-gen', 'original', 'developing..']
# # puts array.length



# vvv 6. PROPER NAME FUNCTION vvv
# vvv [to prep, replace first "array" with input, last "array" with output]

# hold = []
# proper = []
# array.each do |word|
#   if word[0] == word[0].upcase
#     proper << word
#   else
#     if !proper[1].nil?
#       n = proper.join(' ')
#       hold << n
#     end
#     proper.clear
#   end
# end

# print hold
# print array

# array << hold
# print array.flatten


# working on: 
  # taking ( "" , [] {} etc) away from everything
  # taking ( . ) away from ends of words 