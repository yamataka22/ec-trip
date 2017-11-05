class FrontBase < ApplicationController
  layout 'front'
  before_action :store_location
  include ApplicationHelper

  private
  def store_location
    if (request.get? &&
        request.fullpath != new_member_registration_path &&
        request.fullpath != new_member_session_path &&
        request.fullpath !~ Regexp.new("\\A/members/password.*\\z") &&
        request.fullpath != left_member_path &&
        !request.xhr?)
      session[:previous_url] = request.fullpath
    end
  end
end