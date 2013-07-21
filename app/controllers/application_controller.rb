class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :get_post_list, :get_wiki_list

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_path, :alert => exception.message
  end

  def get_post_list
    @post_list=Page.posts.published.order("created_at DESC").limit(5)
  end

  def get_wiki_list
    @wiki_list=Page.wiki.published.order("updated_at DESC").limit(5)
  end

  def not_admin?
    if current_user and current_user.has_role? "admin"
      false
    else
      true
    end
  end
end
