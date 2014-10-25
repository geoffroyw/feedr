# encoding: UTF-8
class FeedsController < ApplicationController
  before_filter :find_feed, :only => :show


  def new
    @new_feed = Feed.new
  end

  def create

    @new_feed = Feed.find_by url: feed_param[:url]
    if @new_feed.nil?
      @new_feed = Feed.new feed_param
    end

    if @feed.save
      unless current_user.feeds.include? @feed
        current_user.feeds << @feed
        current_user.save
      end
      flash[:notice] = 'Le flux a bien été ajouté à votre liste'
      @feed.fetch_items
      redirect_to :homes_show
    else
      @errors = @feed.errors
      flash[:error] = 'Erreur lors de l\'ajout du flux à votre liste'
      render :new
    end

  end


  def show
  end

  private
    def feed_param
      params.require(:feed).permit(:url)
    end

    def find_feed
      @feed = Feed.find(params[:id])
    end
end
