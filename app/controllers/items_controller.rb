class ItemsController < ApplicationController
  before_filter :get_item, :only => :read

  def read
    current_user.items.push @item
    current_user.save

    respond_to do |format|
      format.html {redirect_to root_path}
      format.json { render json: {:success => true}}
    end


  end


  private
  def get_item
    @item = FeedItem.find params[:id]
  end
end
