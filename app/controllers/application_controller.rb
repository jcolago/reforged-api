class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session

  def self.allow_unauthenticated_access
    skip_before_action :authenticate_user, raise: false
  end

  def index
    render file: Rails.root.join("public", "index.html")
  end
end
