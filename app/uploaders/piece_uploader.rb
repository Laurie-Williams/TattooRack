# encoding: utf-8

class PieceUploader < CarrierWave::Uploader::Base

  # Include RMagick or MiniMagick support:
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  # storage :file
  # storage :fog

  # Override the directory where uploaded files will be stored.
  # This is a sensible default for uploaders that are meant to be mounted:
  def store_dir
    if Rails.env.test? || Rails.env.cucumber?
      "uploads/test/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    else
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  end

  def cache_dir
    if Rails.env.test? || Rails.env.cucumber?
      "uploads/test/tmp"
    else
      super
    end
  end

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

  process :crop

  def crop
    x = model.crop_x.to_i
    y = model.crop_y.to_i
    height = model.crop_height.to_i
    width = model.crop_width.to_i

    manipulate! do |img|
      img.crop("#{width}x#{height}+#{x}+#{y}")
    end
    resize_to_fill(840, 630)
  end

  # Create different versions of your uploaded files:
  version :small do
    process :resize_to_fit => [140, 105]
  end

  version :med do
    process :resize_to_fit => [300, 225]
  end

  version :large do
    process :resize_to_fit => [700, 525]
  end

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

end
