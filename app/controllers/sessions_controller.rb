class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create destroy]
  before_action :redirect_if_signed_in, only: %i[new create]

  def new; end

  def create
    if params[:password].present? && params[:password] == find_password
      sign_in!
      redirect_to root_path
    else
      flash[:notice] = "That didn't work"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    sign_out!
    redirect_to new_sessions_path
  end

  private

  def find_password
    return "pass" if Rails.env.development?
    return "pass-test" if Rails.env.test?

    ENV["PRXY_LI_ADMIN_PASSWORD"]
  end
end
