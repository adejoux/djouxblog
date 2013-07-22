class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :cancan_rails4_workaround
  before_filter :get_post_list, :get_wiki_list
  before_filter :configure_permitted_parameters, if: :devise_controller?

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

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:name, :email, :password, :password_confirmation, :remember_me) }
  end

  def cancan_rails4_workaround
    resource = controller_name.singularize.to_sym
    method = "#{resource}_params"
    params[resource] &&= send(method) if respond_to?(method, true)
  end
end
