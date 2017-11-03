# frozen_string_literal: true

class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick
  include cloudinary.carrierwave if Rails.env.production?

  # Choose what kind of storage to use for this uploader:
  storage :file unless Rails.env.production?
  # storage :fog
  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  def default_url
    "/images/no_photo.jpeg"
  end

  # Process files as they are uploaded:
  version :original do
    process resize_to_fit: [500, 600]
  end
  #
  # def scale(width, height)
  #   # do something
  # end

  # Create different versions of your uploaded files:
  version :thumb do
    process resize_to_fit: [50, 50]
  end

  version :standard do
    process resize_to_fill: [100, 150, :north]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_white_list
    %w[jpg jpeg gif png]
  end

  def public_id
    model.id
  end
end
