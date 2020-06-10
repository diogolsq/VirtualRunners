class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :request_email, unless: :devise_controller?

  def request_email
    if current_user && !current_user.email.present?
      redirect_to edit_user_registration_path
    end
  end
end
