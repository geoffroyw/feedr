class HomesController < ApplicationController

  def show

    @items = Item.joins(:feed).where('feeds.id' => @user_feeds.map{|f| f.id}).includes(:feed).paginate(:page => params[:page], :per_page => 15)
  end

end
