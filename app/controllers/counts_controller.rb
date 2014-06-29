class CountsController < ApplicationController

  def index
    @counts = Count.all
  end

  def create
    @count = Count.new(count_params)
  end

  private
    def count_params
      params.require(:count).permit(:qty)
    end

end
