# frozen_string_literal: true

class Public::Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in

  def create
    super
    if !resource.is_active?
      flash[:notice] = nil
      flash[:alert] = "退会済みです"
    end
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    if resource.is_active?
      user = User.find_by(email: params[:user][:email])
      user_path(user.id)
    else
      re_sign_in_users_path
    end
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def guest_sign_in
    user = User.guest
    sign_in user
    redirect_to root_path, notice: "ゲストユーザーとしてログインしました。"
  end

end
