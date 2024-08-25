# frozen_string_literal: true

module Api
  module V1
    class UsersController < ApplicationController
      before_action :validate_user, only: :export_order

      def index
        @users = User.all
        render json: @users
      end

      def export_order
        GenerateOrderCsvJob.perform_async(params[:id])
        render json: {}, status: :ok
      end

      private

      def validate_user
        return unless User.find_by(id: params[:id]).blank?

        render(json: {}, status: :not_found)
      end
    end
  end
end
