class CategoriesController < ApplicationController

  before_filter :find_model, :only => [:edit, :update, :show]

  def index

  end

  def new
    @category = Category.new
    @category.user_feeds.build

  end

  def create

    user_feeds_id = feed_category_param['user_feeds_attributes']

    params = feed_category_param
    params.delete(:user_feeds_attributes)

    @category = Category.new params
    @category.user = current_user



    if @category.save
      update_feed_with_category_id(@category,user_feeds_id)
      flash[:notice] = 'La catégorie a bien été créée'
      redirect_to category_path(@category)
    else
      @errors = @category.errors
      flash[:error] = 'Erreur lors de la création de la catégorie'
      render :new
    end
  end

  def edit
    if @category.user_feeds.count > 0
      @category.user_feeds = []
    end
    @category.user_feeds.build

    render :edit
  end

  def update
    user_feeds_id = feed_category_param['user_feeds_attributes']

    params = feed_category_param
    params.delete(:user_feeds_attributes)

    if @category.update_attributes params
      update_feed_with_category_id(@category, user_feeds_id )
      flash[:success] = 'La catégorie a bien été mise à jour'
      redirect_to category_path(@category)
    else
      @errors = @category.errors
      flash[:error] = 'Erreur lors de la mise à jour de la catégorie'
      render :edit
    end
  end

  def show
    @items = Item.joins(:feed).joins(feed: :user_feeds).where('user_feeds.user_id = ? and user_feeds.category_id = ?', current_user, @category.id).includes(:feed).paginate(:page => params[:page], :per_page => 15)
  end


  private
  def find_model
    @category = Category.where('user_id = ? and id = ?', current_user, params[:id]).first
    if @category.nil?
      raise ActiveRecord::RecordNotFound
    end
  end

  def feed_category_param
      params.require(:category).permit([:name, :parent_id, user_feeds_attributes: [id: []]])
  end

  def update_feed_with_category_id(category, user_feed_ids)

    category.user_feeds.each do |uf|
      uf.category = nil
      uf.save
    end
    unless user_feed_ids.nil?
      user_feed_ids['0']['id'].each do |id|
        uf = UserFeed.where('id = ? and user_id = ?', id, current_user).first
        unless uf.nil?
          uf.category = category
          uf.save
          uf.save
        end
      end
    end
  end
end
