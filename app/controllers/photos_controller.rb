class PhotosController < ApplicationController

  def new
    @photo = Photo.new
  end

  def create
    image_list=""
    ["photo_first", "photo_second", "photo_third", "photo_four"].each_with_index do |pho, index|
      if index==0
        image_list = Magick::ImageList.new(params[pho].path)
      else
        image_list += Magick::ImageList.new(params[pho].path)
      end
    end  
    title = params["title"]
    montage = image_list.montage do
      self.tile     = "2x2"
      self.title = title
    end
    name = Time.now.to_i.to_s + ".png"
    location = ('tmp/'+name)
    montage.write(location)
    photo = current_user.photos.new
    photo.avatar = File.open(location)
    photo.save
    File.delete(location)
    redirect_to root_path
  end

  def show
    @photo = current_user.photos.find(params[:id])
  end

end
