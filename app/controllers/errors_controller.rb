class ErrorsController < ApplicationController
  def routing_error
    raise ActionController::RoutingError,
          "No routes matches #{request.path.inspect}"
  end
end