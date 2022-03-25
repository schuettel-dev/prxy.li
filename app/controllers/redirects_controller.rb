class RedirectsController < ApplicationController
  def new
    link = Link.find_by(token: params[:token])

    if link.present?
      link.visited!
      redirect_to link.target, allow_other_host: true
    else
      head 404
    end
  end
end
