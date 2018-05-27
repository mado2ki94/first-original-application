class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.activated?
        log_in user
        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
        redirect_back_or user
      else
        message  = "登録がまだ完了していません。"
        message += "送信したメールを確認して下さい。"
        flash[:warning] = message
        redirect_to root_url
      end
    else
      flash.now[:danger] = '入力情報に誤りがあります。'
      render 'new'
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end