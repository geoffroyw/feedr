class CategoriesController < ApplicationController

  before_filter :find_model, :only => [:edit, :update, :show]

  def index
    @categories = current_user.categories.includes(:user_feeds)
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

  end

  def update

  end

  def show
    @items = Item.joins(:feed).joins(feed: :user_feeds).where('user_feeds.user_id = ? and user_feeds.category_id = ?', current_user, @category.id).includes(:feed).paginate(:page => params[:page], :per_page => 15)
  end


  private
  def find_model
    @category = Category.where('user_id = ? and id = ?', current_user, params[:id]).first
  end

  def feed_category_param
    params.require(:category).permit([:name, :parent_id])
  end
end
