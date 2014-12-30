class HomeController < ApplicationController
  before_action :authenticate_user!

  def index
    @photos = current_user.photos
  end
end
