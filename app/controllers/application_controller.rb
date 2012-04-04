class ApplicationController < ActionController::Base
  protect_from_forgery
  
  after_filter :set_content_type
  
  protected
  def set_content_type
    headers['Content-Type'] ||= 'application/xhtml+xml; charset=utf-8'
  end
end
