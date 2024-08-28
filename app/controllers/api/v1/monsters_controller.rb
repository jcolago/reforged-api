module Api
  module V1
    class MonstersController < ApplicationController
      def index
        @monsters = Monster.all
        render json: @monsters
      end

      def show
        @monster = Monster.find(params[:id])
        render json: @monster
      end

      def create
        @monster = Monster.new(monster_params)
        if @monster.save
          render json: @monster, status: :created
        else
          render json: @monster.errors, status: :unprocessable_entity
        end
      end

      def update
        @monster = Monster.find(params[:id])
        if @monster.update(monster_params)
          render json: @monster
        else
          render json: @monster.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @monster = Monster.find(params[:id])
        @monster.destroy
        head :no_content
      end

      private

      def monster_params
        params.require(:monster).permit(:name, :size, :alignmanet, :armor_class, :hit_points, :speed, :resistances, :p_bonus, :attacks, :displayed, :game_id)
      end
    end
  end
end
