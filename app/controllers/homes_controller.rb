class HomesController < ApplicationController

  def show
    #@feeds = current_user.feeds
    @items = FeedItem.joins(:feed).where('feeds.id' => current_user.feeds.map{|f| f.id}).paginate(:page => params[:page], :per_page => 15)
    @user_read_items = current_user.items
  end

end
