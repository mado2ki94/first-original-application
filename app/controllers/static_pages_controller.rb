class StaticPagesController < ApplicationController
  
  def home
    if logged_in?
      @foodpost = current_user.foodposts.build if logged_in?
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end
  
end
