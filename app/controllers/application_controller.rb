class ApplicationController < ActionController::Base
  before_action :authenticate
  helper_method :signed_in?

  private

  def redirect_if_signed_in
    redirect_to(root_path) if signed_in?
  end

  def authenticate
    return if signed_in?

    redirect_to new_sessions_path
  end

  def signed_in?
    session[:signed_in] === true
  end

  def sign_in!
    session[:signed_in] = true
  end

  def sign_out!
    session[:signed_in] = false
  end
end
