# encoding: utf-8

class AvatarUploader < CarrierWave::Uploader::Base
  #include CarrierWave::MiniMagick
  include CarrierWave::RMagick
  
  process :resize_to_fit => [800, 800]
  version :thumb do
    process :resize_to_fit => [200,200]
  end

  version :medium do
    process :resize_to_fit => [400,400]
  end
  # Include RMagick or MiniMagick support:
   
  # include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def extension_white_list
    %w(jpg jpeg gif png)
  end

  def default_url
    asset_path "missing.png"
  end
=begin

  version :small do
    process :resize_to_fill => [50, 50]
    version :sprite do
      process :make_sprite
    end
  end

  # Combine images to a sprite
  def make_sprite
    manipulate! do |img|
      list = Magick::ImageList.new
      list << img
      list << img.quantize(256, Magick::GRAYColorspace)
      img = list.append(true)
    end
  end
=end
=begin
  %w[red green blue purple black].each do |color|
    version(color) { process stamp: color }
  end

  def stamp(color)
    manipulate! format: "png" do |source|
      overlay_path = Rails.root.join("app/assets/images/stamp_overlay.png")
      overlay = Magick::Image.read(overlay_path).first
      source = source.resize_to_fill(70, 70).quantize(256, Magick::GRAYColorspace).contrast(true)
      source.composite!(overlay, 0, 0, Magick::OverCompositeOp)
      colored = Magick::Image.new(70, 70) { self.background_color = color }
      colored.composite(source.negate, 0, 0, Magick::CopyOpacityCompositeOp)
    end
  end

=end
  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url
  #   # For Rails 3.1+ asset pipeline compatibility:
  #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process :scale => [200, 300]
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  # version :thumb do
  #   process :resize_to_fit => [50, 50]
  # end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  # def extension_white_list
  #   %w(jpg jpeg gif png)
  # end

  # Override the filename of the uploaded files:
  # Avoid using model.id or version_name here, see uploader/store.rb for details.
  # def filename
  #   "something.jpg" if original_filename
  # end

  def resize(width, height, gravity = 'Center')
    manipulate! do |img|
      img.combine_options do |cmd|
        cmd.resize width.to_s
        if img[:width] < img[:height]
          cmd.gravity gravity
          cmd.background "rgba(255,255,255,0.0)"
          cmd.extent "#{width}x#{height}"
        end
      end
      img = yield(img) if block_given?
      img
    end
  end

end
