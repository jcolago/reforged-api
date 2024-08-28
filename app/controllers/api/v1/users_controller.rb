module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users.as_json(except: :password_digest)
      end

      def show
        @user = User.find(params[:id])
        render json: @user.as_json(except: :password_digest)
      end

      def create
        @user = User.new(user_params)
        if @user.save
          render json: @user.as_json(except: :password_digest), status: :created
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def update
        @user = User.find(params[:id])
        if @user.update(user_params)
          render json: @user.as_json(except: :password_digest)
        else
          render json: @user.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @user = User.find(params[:id])
        @user.destroy
        head :no_content
      end

      private

      def user_params
        params.require(:user).permit(:email, :password, :password_confirmation)
      end

      # Need to revisit this, will check in when front end is set up
      def login
        @user = User.find_by(email: params[:email])
        if @user&.authenticate(params[:password])
          # Here you would generate and return a token for authentication
          render json: { message: "Logged in successfully", user_id: @user.id }
        else
          render json: { error: "Invalid email or password" }, status: :unauthorized
        end
      end
    end
  end
end
