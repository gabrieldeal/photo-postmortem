# frozen_string_literal: true

require 'exif'
require 'mini_exiftool_vendored'

module Photo
  module Postmortem
    # Hide the difference between the different EXIF parsers we use.
    class Exif
      attr_accessor :creation_time,
                    :creator

      def initialize(photo_path)
        initialize_fast(photo_path) || initialize_comprehensive(photo_path)
      end

      # This is fast but doesn't support many image formats (like DNG).
      def initialize_fast(photo_path)
        exif = ::Exif::Data.new(photo_path)
        self.creation_time = exif.date_time_original
        self.creator = exif.artist
        true
      rescue ::Exif::NotReadable
        false
      end

      # This is slow but supports almost all image formats.
      def initialize_comprehensive(photo_path)
        exif = MiniExiftool.new(photo_path)
        self.creation_time = exif.create_date
        self.creator = exif.artist
      end
    end
  end
end
