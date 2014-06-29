class ArticlesController < ApplicationController
  def index
    @articles = Article.all
  end

  def create
    @article = Article.new(article_params)
  end

  private
    def article_params
      params.require(:article).permit(:title, :date, :url)
    end

end
