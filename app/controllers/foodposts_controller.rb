class FoodpostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
    before_action :correct_user,   only: :destroy
    
    def index
    end
    
    def create
        @foodpost = current_user.foodposts.build(foodpost_params)
        if @foodpost.save
            flash[:success] = "投稿しました。"
            redirect_to root_url
        else
            @feed_items = []
            render 'static_pages/home'
        end
    end

    def destroy
        @foodpost.destroy
        flash[:success] = "投稿を削除しました。"
        redirect_to request.referrer || root_url
    end
  
    def edit
        @foodpost = Foodpost.find_by(params[:id])
    end

    def update
    end
    
    def show
    end
    
    private

    def foodpost_params
      params.require(:foodpost).permit(:picture, :content, :protein, :fat, :carbohydrate)
    end
    
    def correct_user
      @foodpost = current_user.foodposts.find_by(id: params[:id])
      redirect_to root_url if @foodpost.nil?
    end
end
