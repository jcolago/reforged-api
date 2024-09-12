module Api
  module V1
    class PlayersController < ApplicationController
      def index
        @players = Player.all
        render json: @players
      end

      def show
        @player = Player.find(params[:id])
        render json: @player
      end

      def create
        @player = Player.new(player_params)
        if @player.save
          render json: @player, status: :created
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      def update
        @player = Player.find(params[:id])
        if @player.update(player_params)
          render json: @player
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @player = Player.find(params[:id])
        @player.destroy
        head :no_content
      end

      def update_hp
        @player = Player.find(params[:id])
        if @player.update(current_hp: params[:current_hp])
          render json: @player
        else
          render json: @player.errors, status: :unprocessable_entity
        end
      end

      private

      def player_params
        params.require(:player).permit(:name, :character, :image, :level, :current_hp, :total_hp,
                                       :armor_class, :speed, :initiative_bonus,
                                       :strength, :strength_save,
                                       :dexterity, :dexterity_save,
                                       :constitution, :constitution_save,
                                       :intelligence, :intelligence_save,
                                       :wisdom, :wisdom_save,
                                       :charisma, :charisma_save,
                                       :displayed, :game_id)
      end
    end
  end
end
