class PagesController < ApplicationController

  def index
    user_input = params[:submit]
    if user_input != nil      
      searched = Word.where(ord: user_input).take
      if searched.nil?
        flash.now[:alert] = "That word/phrase was not found"
        render "index"
      else
        @articles = searched.articles
      end
    else
      @articles = nil
    end
  end

end
