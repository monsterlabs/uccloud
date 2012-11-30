class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    if params[:auth_token]
      "/accounts/join"
    else
      root_path
    end
  end
end
