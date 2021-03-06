class AccountActivationsController < ApplicationController

  def edit
    user = User.find_by(email: params[:email])
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.activate
      log_in user
      flash[:success] = "登録が完了しました！"
      redirect_to user
    else
      flash[:danger] = "エラーが発生しました。もう一度会員登録からやり直して下さい。"
      redirect_to root_url
    end
  end
end