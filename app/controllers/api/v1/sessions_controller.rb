# app/controllers/api/v1/sessions_controller.rb
module Api
  module V1
    class SessionsController < ApplicationController
      include ApiAuthentication

      allow_unauthenticated_access only: [ :login ]
      rate_limit to: 10, within: 3.minutes, only: :login, with: -> {
        render json: { error: "Too many attempts. Please try again later." },
        status: :too_many_requests
      }

      def login
        user = User.find_by(email: params[:email])
        if user&.authenticate(params[:password])
          session = create_session_for(user)
          token = generate_token_for(user, session)

          render json: {
            token: token,
            user: user.as_json(except: [ :password_digest ]) # Only send necessary user data
          }
        else
          render json: { error: "Invalid email address or password." }, status: :unauthorized
        end
      end

      def me
        render json: {
          user: Current.user.as_json(except: [ :password_digest ])
        }
      end

      def logout
        if Current.session&.destroy
          render json: { message: "Logged out successfully." }
        else
          render json: { error: "No active session found." }, status: :bad_request
        end
      end

      private

      def create_session_for(user)
        user.sessions.create!(
          user_agent: request.user_agent,
          ip_address: request.remote_ip
        ).tap { |session| Current.session = session }
      end

      def generate_token_for(user, session)
        payload = {
          user_id: user.id,
          session_id: session.id,
          exp: 24.hours.from_now.to_i # Token expires in 24 hours
        }
        JWT.encode(payload, Rails.application.secret_key_base, "HS256")
      end
    end
  end
end
