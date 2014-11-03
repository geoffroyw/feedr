class ItemsController < ApplicationController
  before_filter :get_item, :only => [:read, :show, :view]

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


  def view
    if @item.view_count.nil?
      @item.view_count=1
    else
      @item.view_count=@item.view_count+1
    end
    @item.save!
    redirect_to @item.url
  end


  private
  def get_item
    @item = Item.find params[:id]
  end

  def mark_as_read
    if @item.read_count.nil?
      @item.read_count=1
    else
      @item.read_count=@item.read_count+1
    end
    @item.save!
    current_user.items.push @item
    current_user.save
  end
end
