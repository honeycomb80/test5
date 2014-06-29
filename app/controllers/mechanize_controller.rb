class MechanizeController < ApplicationController
require "nokogiri"
require "mechanize"
require "rubygems"
require "open-uri"


before_action :set_agent_get, only:[:get_articles]

def get_articles(pg = 2, article_date = Date.today)
  agent = Mechanize.new
  tc = agent.get('http://www.techcrunch.com/')
  article_pg_count = 0


  until article_date === Date.today - 10
    tc.root.css('li.river-block').each do |link|
      if link['data-permalink'].nil?
        pp link.css('a')[0]['href']
        pp link.css('a')[0].text
      else
        pp link['data-permalink']
        pp link['data-sharetitle']
      end
      article_date = link.css('time')[0]['datetime']
      article_date = Date.parse(article_date)
      pp article_date
      article_pg_count += 1
      pp "Article: #{article_pg_count}"
      if article_pg_count == 20
        tc = tc.link_with(:href => %r{page/#{pg}}i).click
        tc
        pg += 1
        article_pg_count = 0
      end
    end    
  end
end


    
      Article.create(title: link.text, url: link.href, date: Date.new(2014,6,24))
    end
  end

end

private
  def set_agent_get
    agent = Mechanize.new
    tc = agent.get('http://www.techcrunch.com/')
  end