class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  
  def index
    render file: Rails.root.join('public', 'index.html')
  end
end