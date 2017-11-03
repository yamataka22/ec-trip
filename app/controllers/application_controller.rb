class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  class Forbidden < ActionController::ActionControllerError; end

  include ErrorHandlers
end
