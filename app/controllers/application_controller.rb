class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_page_list

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def get_page_list
    @page_list=Page.order("created_at DESC").limit(5)
  end
end
