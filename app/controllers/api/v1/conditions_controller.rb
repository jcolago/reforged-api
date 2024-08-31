module Api
  module V1
    class ConditionsController < ApplicationController
      before_action :set_condition, only: [ :show, :update, :destroy ]

      # GET /api/v1/conditions
      def index
        @conditions = Condition.all
        render json: @conditions
      end

      # GET /api/v1/conditions/1
      def show
        render json: @condition
      end

      # POST /api/v1/conditions
      def create
        @condition = Condition.new(condition_params)

        if @condition.save
          render json: @condition, status: :created
        else
          render json: @condition.errors, status: :unprocessable_entity
        end
      end

      # PATCH/PUT /api/v1/conditions/1
      def update
        if @condition.update(condition_params)
          render json: @condition
        else
          render json: @condition.errors, status: :unprocessable_entity
        end
      end

      # DELETE /api/v1/conditions/1
      def destroy
        @condition.destroy
        head :no_content
      end

      private

      def set_condition
        @condition = Condition.find(params[:id])
      end

      def condition_params
        params.require(:condition).permit(:name)
      end
    end
  end
end
