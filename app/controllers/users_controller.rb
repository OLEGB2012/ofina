# encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!, :except => [:get_enterprises_by_user_email]
  
  def show
    @user=User.find_by_id(current_user)
  end
  
  # По email-пользователя выдать его предприятия ...
  def get_enterprises_by_user_email
    @user_api=User.find_by_email(params[:email])
    respond_to do |format|
      if not @user_api.nil?
        format.xml { render :xml => [@user_api, @user_api.enterprises], :only => [:id,:username,:email,:user_id,:org_name] }
      end
    end
  end  
end
