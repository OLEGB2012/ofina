# encoding: utf-8
class UsersController < ApplicationController
  before_filter :authenticate_user!
  
  def edit
    @user=User.find_by_id(current_user)
  end
  
  def update
    @user=User.find_by_id(current_user)
    if @user.update_attributes(params[:user])
      flash[:notice]="Профиль учётной записи обновлён."
      redirect_to root_path
    else  
      render('edit')
    end
  end
end
