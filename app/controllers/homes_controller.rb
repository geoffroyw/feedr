class HomesController < ApplicationController

  def show

    @items = FeedItem.joins(:feed).where('feeds.id' => @user_feeds.map{|f| f.id}).paginate(:page => params[:page], :per_page => 15)
    @user_read_items = current_user.items
  end

end
