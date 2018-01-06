# frozen_string_literal: true

module Search
  module Query
    class GeoLocationQuery < Function
      def initialize(conditions)
        @conditions = conditions
      end

      def geo_query
        return {} unless @conditions[:location]

        geo_distance_query
      end

      private

      def geo_distance_query
        {
          geo_distance: {
            distance: @conditions[:location][:distance] || '100km',
            location: {
              lat: @conditions[:location][:lat],
              lon: @conditions[:location][:lon]
            }
          }
        }
      end
    end
  end
end
