class RedirectsController < ApplicationController
  skip_before_action :authenticate, only: %i[new]

  def new
    link = Link.find_by(token: params[:token])

    if link.present?
      link.visited!
      redirect_to link.target_with_https, allow_other_host: true
    else
      head :not_found
    end
  end
end
