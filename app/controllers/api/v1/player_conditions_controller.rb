module Api
  module V1
    class PlayerConditionsController < ApplicationController
      before_action :set_player_condition, only: [ :show, :update, :destroy ]

      def index
        @player_conditions = PlayerCondition.all
        render json: @player_conditions
      end

      def show
        render json: @player_condition
      end

      def create
        @player_condition = PlayerCondition.new(player_condition_params)

        if @player_condition.save
          render json: @player_condition, status: :created
        else
          render json: @player_condition.errors, status: :unprocessable_entity
        end
      end

      def update
        if @player_condition.update(player_condition_params)
          render json: @player_condition
        else
          render json: @player_condition.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @player_condition.destroy
        head :no_content
      end

      private

      def set_player_condition
        @player_condition = PlayerCondition.find(params[:id])
      end

      def player_condition_params
        params.require(:player_condition).permit(:condition_length, :condition_id, :player_id)
      end
    end
  end
end
