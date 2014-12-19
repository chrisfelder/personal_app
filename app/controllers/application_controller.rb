class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # we move the session's helper, here, so that we can access it throughout
  # the application.
  include SessionsHelper
end
