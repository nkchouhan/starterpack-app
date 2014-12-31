class HomeController < ApplicationController

  def index
    @photos = Photo.all.desc.page params[:page]
  end
end
