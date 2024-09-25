class Api::SessionsController < Api::ApiController
  include ApiAuthentication

  allow_unauthenticated_access only: [ :login ]

  def login
    if user = User.authenticate_by(params.permit(:email_address, :password))
      payload = { user_id: user.id }
      user.sessions.create!(user_agent: request.user_agent, ip_address: request.remote_ip).tap do |session|
        Current.session = session
        payload[:session_id] = session.id
      end
      jwt = JWT.encode payload, Rails.application.secret_key_base, "HS256"
      render json: { token: jwt }
    else
      render json: { error: "Invalid email address or password." }, status: :unauthorized
    end
  end

  def me
    render json: { user: Current.session.user }
  end

  def logout
    Current.session.destroy
    render json: { message: "Logged out successfully." }
  end
end
