class ItemsController < ApplicationController
  before_filter :get_item, :only => [:read, :show]

  def read
    mark_as_read

    respond_to do |format|
      format.json { render json: {:success => true}}
    end
  end


  def show
    mark_as_read
    render :partial => 'item_content'
  end


  private
  def get_item
    @item = Item.find params[:id]
  end

  def mark_as_read
    current_user.items.push @item
    current_user.save
  end
end
