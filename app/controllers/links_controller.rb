class LinksController < ApplicationController
  before_action :require_login

  def index
    links = Link.by_user(current_user.id)
    @read_links ||= links.where(read: true)
    @unread_links ||= links.where(read: false)
  end

  def new
    @link = Link.new
  end

  def edit
    @link = Link.find_by(id: params[:id])
  end

  def create
    link = current_user.links.new(link_params)
    if link.save
      flash[:notice] = "Link successfully created!"
      redirect_to links_path
    else
      flash[:errors] = link.errors.full_messages.first
      redirect_to links_path
    end
  end

  def update
    @link = Link.find_by(id: params[:id])
    if params[:link][:read] && @link.update_attributes(read: params[:link][:read])
      flash[:notice] = "Link updated!"
      redirect_to links_path
    elsif params[:link][:read] == nil && @link.update_attributes(link_params)
      flash[:notice] = "Link updated!"
      redirect_to links_path
    else
      flash[:errors] = "Link did not update!"
      redirect_to edit_link_path(@link.id)
    end
  end

private

  def link_params
    params.require(:link).permit(:title, :url)
  end
end
