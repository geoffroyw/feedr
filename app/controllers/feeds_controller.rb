class FeedsController < ApplicationController



  def new
    @feed = Feed.new
  end

  def create
    @fee = Feed.new params

  end
end
