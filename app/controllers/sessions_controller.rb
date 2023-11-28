class SessionsController < ApplicationController
  skip_before_action :authenticate, only: %i[new create destroy]
  before_action :redirect_if_signed_in, only: %i[new create]

  def new; end

  def create
    if params[:password].present? && params[:password] == find_password
      sign_in!
      redirect_to root_path
    else
      flash[:notice] = "That didn't work" # rubocop:disable Rails/I18nLocaleTexts
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

    Rails.application.credentials.admin_password
  end
end
