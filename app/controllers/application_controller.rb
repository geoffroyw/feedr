class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_filter :authenticate_user!

  before_filter :build_new_feed, :fetch_user_feeds

  private
  def build_new_feed
    @new_feed = Feed.new
  end

  def fetch_user_feeds
    if current_user.nil?
      @uncategorized_user_feeds = []
      @categories = []
    else
      @user_feeds = current_user.user_feeds.includes(:feed)
      @uncategorized_user_feeds = @user_feeds.where('category_id is null')
      @categories = current_user.categories.roots.includes(:children, user_feeds: :feed)
    end

  end

end
