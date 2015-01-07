class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  include SessionsHelper
  include ApplicationHelper

  rescue_from ActsAsTenant::Errors::NoTenantSet, with: :no_subdomain

  set_current_tenant_by_subdomain(:account, :subdomain)

  def require_login
    unless logged_in?
      flash[:info] = "You must be logged in to visit this page. Please log in."
      redirect_to login_path
    end
  end

  def require_admin
    unless admin?
      flash[:info] = "You must have administration privileges to access the page you requested"
      if logged_in?
        redirect_to root_path
      else
        redirect_to login_path
      end
    end
  end

  private
    def no_subdomain
      render "/public/nosubdomain.html", layout: false
    end
end
