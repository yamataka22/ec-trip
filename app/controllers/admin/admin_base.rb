class Admin::AdminBase < ApplicationController
  layout 'admin'
  helper 'admin'
  before_action :authenticate_manager!
end