class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_post_list

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def get_post_list
    @post_list=Post.order("created_at DESC").limit(5)
  end
end
