class LinksController < ApplicationController
  def index
    @links = Link.anti_chronologically
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)

    if @link.save
      redirect_to links_path
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    @link = Link.find(params[:id])
    @link.destroy
    redirect_to links_path
  end

  private

  def link_params
    params.require(:link).permit(:target)
  end
end
