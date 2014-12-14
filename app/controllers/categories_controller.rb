class CategoriesController < ApplicationController

  before_filter :find_model, :only => [:edit, :update, :show, :destroy]

  def index
    @categories = current_user.categories.includes(:user_feeds).roots.includes(:user_feeds, :children)
  end

  def new
    @category = Category.new
    @category.user_feeds.build

  end

  def create
    @category = Category.new feed_category_param
    @category.user = current_user

    if @category.save
      flash[:notice] = 'La catégorie a bien été créée'
      redirect_to category_path(@category)
    else
      @errors = @category.errors
      flash[:error] = 'Erreur lors de la création de la catégorie'
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @category.update_attributes feed_category_param
      flash[:success] = 'La catégorie a bien été mise à jour'
      redirect_to category_path(@category)
    else
      @errors = @category.errors
      flash[:error] = 'Erreur lors de la mise à jour de la catégorie'
      render :edit
    end
  end

  def show
    @items = Item.joins(:feed).joins(feed: [user_feeds: :categories]).where('user_feeds.user_id = ? and categories.id = ?', current_user, @category.id).includes(:feed).paginate(:page => params[:page], :per_page => 15)
  end


  def destroy
    @category.destroy
    redirect_to categories_path
  end

  private
  def find_model
    @category = Category.where('user_id = ? and id = ?', current_user, params[:id]).first
    if @category.nil?
      raise ActiveRecord::RecordNotFound
    end
  end

  def feed_category_param
      params.require(:category).permit([:name, :parent_id])
  end

end
