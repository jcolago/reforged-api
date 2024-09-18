module ApiAuthentication
  extend ActiveSupport::Concern

  included do
    before_action :require_authentication
    helper_method :authenticated?
  end

  class_methods do
    def allow_unauthenticated_access(**options)
      skip_before_action :require_authentication, **options
    end
  end

  private
    def authenticated?
      Current.session.present?
    end

    def require_authentication
      resume_session || return_unauthorized
    end


    def resume_session
      Current.session = find_session_by_jwt
    end

    def find_session_by_jwt
      token = request.headers["Authorization"]&.split(" ")&.last
      return unless token

      payload = JWT.decode(token, Rails.application.secret_key_base, true, algorithm: "HS256").first
      Session.find_by(id: payload["session_id"])
    end

    def return_unauthorized
      render json: { error: "Not authenticated." }, status: :unauthorized
    end
end
