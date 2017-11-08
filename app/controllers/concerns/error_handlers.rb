module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    if Rails.env.production?
      rescue_from Exception, with: :rescue500
      rescue_from ActionController::ParameterMissing, with: :rescure400
      rescue_from ApplicationController::Forbidden, with: :rescue403
      rescue_from ActionController::RoutingError, with: :rescue404
      rescue_from ActiveRecord::RecordNotFound, with: :rescue404
    end
  end

  private
  def rescue400(e)
    @exception = e
    render '/errors/bad_request', status: 400, layout: layout
  end

  def rescue403(e)
    @exception = e
    render '/errors/forbidden', status: 403, layout: layout
  end

  def rescue404(e)
    @exception = e
    render '/errors/not_found', status: 404, layout: layout
  end

  def rescue500(e)
    @exception = e
    logger.fatal e.message
    logger.fatal e.backtrace.join("\n")
    render '/errors/internal_server_error', status: 500, layout: layout
  end

  def layout
    request.fullpath.start_with?('/admin') ? 'admin' : 'front'
  end
end