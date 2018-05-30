class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :destroy,
                                        :following, :followers]
  before_action :correct_user,   only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @foodposts = @user.foodposts.paginate(page: params[:page])
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      @user.send_activation_email
      flash[:info] = "指定のメールアドレスにメールを送信しました。メール内のリンクをクリックして登録を完了させて下さい。"
      redirect_to root_url
    else
      render 'new'
    end
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    if @user.update_attributes(user_params)
      flash[:success] = "登録情報を変更しました。"
      redirect_to @user
    else
      render 'edit'
    end
  end
  
  def following
    @title = "Following"
    @user  = User.find(params[:id])
    @users = @user.following.paginate(page: params[:page])
    render 'show_follow'
  end

  def followers
    @title = "Followers"
    @user  = User.find(params[:id])
    @users = @user.followers.paginate(page: params[:page])
    render 'show_follow'
  end
  
  private

    def user_params
      params.require(:user).permit(:avatar, :introduction, :name, :email,
                                   :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
    end
end
