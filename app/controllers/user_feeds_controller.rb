class UserFeedsController < ApplicationController
  before_filter :find_user_feed, :only => [:edit, :update]

  def edit
    render :edit
  end


  def update
    if @user_feed.update_attributes user_feed_param
      flash[:success] = 'Le flux a bien été mis à jour'
      redirect_to feed_path(@user_feed.feed)
    else
      @errors = @user_feed.errors
      render :edit
    end
  end

  def unread_item_count
    ret = []
    @user_feeds.each do |uf|
      ret << {'id' => uf.id, 'count' => uf.unread_item_count}
    end
    respond_to do |format|
      format.json { render json: {:success => true, :values => ret.to_json}}
    end
  end

  private
  def find_user_feed
    user_feeds = UserFeed.where('user_id = ? and feed_id = ?', current_user.id, params[:id])
    if user_feeds.count != 1
      raise ActiveRecord::RecordNotFound
    else
      @user_feed = user_feeds.first
      @user_feed_base = UserFeed.new(@user_feed.attributes)
    end
  end

  def user_feed_param
    params.require(:user_feed).permit(:name, :category_ids => [] )
  end
end
