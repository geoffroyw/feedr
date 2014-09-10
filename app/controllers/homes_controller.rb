class HomesController < ApplicationController

  def show
    @feeds = current_user.feeds
  end

end
