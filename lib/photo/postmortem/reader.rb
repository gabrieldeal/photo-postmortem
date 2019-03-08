# frozen_string_literal: true

require 'photo/postmortem/version'

module Photo
  module Postmortem
    # Gather statistics from photo files.
    class Reader
      attr_accessor :creation_times,
                    :exif,
                    :focal_lengths,
                    :timezone

      def initialize(timezone:)
        self.creation_times = []
        self.focal_lengths = {}
        self.timezone = timezone
      end

      def process(photo_path)
        self.exif = Photo::Postmortem::Exif.new(photo_path)

        process_focal_length
        process_creation_time
      end

      private

      def process_focal_length # rubocop:disable Metrics/AbcSize
        return unless exif.focal_length

        focal_lengths['all'] ||= {}
        focal_lengths['all'][exif.focal_length] ||= 0
        focal_lengths['all'][exif.focal_length] += 1

        focal_lengths[exif.camera] ||= {}
        focal_lengths[exif.camera][exif.focal_length] ||= 0
        focal_lengths[exif.camera][exif.focal_length] += 1
      end

      def process_creation_time
        return unless exif.creation_time

        creation_time = exif.creation_time
        creation_time = creation_time.in_time_zone(timezone) if timezone
        creation_times << creation_time
      end
    end
  end
end
