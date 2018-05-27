class FoodpostsController < ApplicationController
    before_action :logged_in_user, only: [:create, :destroy, :edit, :update]
    before_action :correct_user,   only: :destroy
    
    def index
        @user = current_user
        @foodposts = Foodpost.paginate(page: params[:page])
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
        @foodpost = Foodpost.find(params[:id])
    end

    def update
        @foodpost = Foodpost.find(params[:id])
        if @foodpost.update_attributes(foodpost_params)
          flash[:success] = "更新しました。"
          redirect_to current_user
        else
          render 'edit'
        end
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
