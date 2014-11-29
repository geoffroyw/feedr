class CategoriesController < ApplicationController

  before_filter :find_model, :only => [:edit, :update, :show]

  def index
    @categories = current_user.categories.includes(:user_feeds, :children)

  end

  def new
    @new_category = Category.new
  end

  def create
    @new_category = Category.new feed_category_param
    @new_category.user = current_user

    if @new_category.save
      flash[:notice] = 'La catégorie a bien été créée'
      redirect_to category_path(@new_category)
    else
      @errors = @new_category.errors
      flash[:error] = 'Erreur lors de la création de la catégorie'
      render :new
    end
  end

  def edit
    render :edit
  end

  def update
    if @category.update_attributes feed_category_param
      flash[:success] = 'La catégorie a bien été mis à jour'
      redirect_to categories_path
    else
      @errors = @category.errors
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
    params.require(:category).permit([:name, :parent_id])
  end
end
