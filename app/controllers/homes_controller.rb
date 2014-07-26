class HomesController < ApplicationController

  def show
    @feeds = Feed.all
  end

end
