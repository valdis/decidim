# frozen_string_literal: true

module Decidim
  module Conferences
    class ConferenceRegistrationSerializer < Decidim::Exporters::Serializer
      # Serializes a conference registration
      def serialize
        {
          id: resource.id,
          user: {
            name: resource.user.name,
            email: resource.user.email
          },
          registration_type: resource.registration_type.title
        }
      end
    end
  end
end
