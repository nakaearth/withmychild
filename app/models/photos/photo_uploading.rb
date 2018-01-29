# frozen_string_literal: true

module Photos
  class PhotoUploading
    def self.execute(place, photo_params)
      new.instance_eval do
        @photo = place.photos.build(photo_params)

        execute
      end
    end

    private

    def execute
      ActiveRecord::Base.transaction do
        @photo.save!
      end
    end
  end
end
