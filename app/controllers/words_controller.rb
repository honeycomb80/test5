class WordsController < ApplicationController

  def index
    @words = Word.all
  end

  def new
    @word = Word.new
  end

  def create
    @word = Word.new(word_params)

    respond_to do |format|
      if @word.save
        format.html { redirect_to root_path, notice: 'Thing was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  private
    def word_params
      params.require(:word).permit(:ord)
    end

end
