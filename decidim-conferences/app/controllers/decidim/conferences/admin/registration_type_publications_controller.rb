# frozen_string_literal: true

module Decidim
  module Conferences
    module Admin
      # Controller that allows managing registration type publications.
      #
      class RegistrationTypePublicationsController < Decidim::Conferences::Admin::ApplicationController
        include Concerns::ConferenceAdmin

        # def create
        #   enforce_permission_to :publish, :conference, conference: current_conference
        #
        #   PublishConference.call(current_conference, current_user) do
        #     on(:ok) do
        #       flash[:notice] = I18n.t("conference_publications.create.success", scope: "decidim.admin")
        #     end
        #
        #     on(:invalid) do
        #       flash.now[:alert] = I18n.t("conference_publications.create.error", scope: "decidim.admin")
        #     end
        #
        #     redirect_back(fallback_location: conferences_path)
        #   end
        # end
        #
        # def destroy
        #   enforce_permission_to :publish, :conference, conference: current_conference
        #
        #   UnpublishConference.call(current_conference, current_user) do
        #     on(:ok) do
        #       flash[:notice] = I18n.t("conference_publications.destroy.success", scope: "decidim.admin")
        #     end
        #
        #     on(:invalid) do
        #       flash.now[:alert] = I18n.t("conference_publications.destroy.error", scope: "decidim.admin")
        #     end
        #
        #     redirect_back(fallback_location: conferences_path)
        #   end
        # end

        def create
          @registration_type = collection.find(params[:registration_type_id])
          enforce_permission_to :publish, :registration_type, registration_type: @registration_type

          PublishRegistrationType.call(@registration_type, current_user) do
            on(:ok) do
              flash[:notice] = I18n.t("registration_types.publish.success", scope: "decidim.admin")
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("conference_publications.create.error", scope: "decidim.admin")
            end

            redirect_back(fallback_location: conference_registration_types_path(current_conference))
          end
        end

        def destroy
          @registration_type = collection.find(params[:registration_type_id])
          enforce_permission_to :unpublish, :registration_type, registration_type: @registration_type

          UnpublishRegistrationType.call(@registration_type, current_user) do
            on(:ok) do
              flash[:notice] = I18n.t("registration_types.unpublish.success", scope: "decidim.admin")
            end

            on(:invalid) do
              flash.now[:alert] = I18n.t("registration_types.destroy.error", scope: "decidim.admin")
            end

            redirect_back(fallback_location: conference_registration_types_path(current_conference))
          end
        end

        private

        def collection
          @collection ||= Decidim::Conferences::RegistrationType.where(conference: current_conference)
        end

      end
    end
  end
end
