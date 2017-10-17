class ImageUploader < CarrierWave::Uploader::Base
  include CarrierWave::MiniMagick

  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  version :thumb do
    process resize_to_fit: [150, 90]
  end

  version :normal do
    process resize_to_fit: [450, 270]
  end

  def extension_whitelist
    %w[jpg jpeg gif png]
  end
end
