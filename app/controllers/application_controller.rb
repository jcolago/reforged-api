# app/controllers/application_controller.rb
class ApplicationController < ActionController::API  # Note: Using ActionController::API instead of Base
  def self.allow_unauthenticated_access(options = {})
    skip_before_action :authenticate_user, options.merge(raise: false)
  end
end
