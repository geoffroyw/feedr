class ItemsController < ApplicationController
  before_filter :get_item, :only => :read

  def read
    current_user.items.push @item
    current_user.save


    redirect_to home_path

  end


  private
  def get_item
    @item = FeedItem.find params[:id]
  end
end
