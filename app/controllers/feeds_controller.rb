# encoding: UTF-8
class FeedsController < ApplicationController



  def new
    @feed = Feed.new
  end

  def create

    puts 'here'

    @feed = Feed.new feed_param

    if @feed.save
      flash[:notice] = 'Le flux a bien été ajouté à votre liste'
      @feed.fetch_items
      redirect_to :homes_show
    else
      @errors = @feed.errors
      flash[:error] = 'Erreur lors de l\'ajout du flux à votre liste'
      render :new
    end

  end


  private
    def feed_param
      params.require(:feed).permit(:name, :url)
    end
end
