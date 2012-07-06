# encoding: utf-8
class EnterprisesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprises=Enterprise.UserAreaFor(current_user.id).paginate(page: params[:page])    
  end
  
  def show
    @enterprise=Enterprise.find(params[:id])
  end
    
  def edit
    @enterprise=Enterprise.find(params[:id])
  end
  
  def new
    @enterprise=Enterprise.new    
  end  
  
  def delete
    @enterprise=Enterprise.find(params[:id])
  end
  
  def create
    @enterprise=Enterprise.new(params[:enterprise])
    @enterprise=current_user.enterprises.build(params[:enterprise])
    if @enterprise.save
      flash[:notice]="Предприятие создано."
      redirect_to enterprises_path
    else
      render('new')
    end
  end
  
  def update
    @enterprise=Enterprise.find(params[:id])
    if @enterprise.update_attributes(params[:enterprise])
      flash[:notice]="Предприятие обновлено."
      redirect_to enterprise_path(@enterprise)
    else  
      render('edit')
    end
  end
  
  def destroy
    enterprise=Enterprise.find(params[:id])
    enterprise.destroy
    flash[:notice]="Предприятие удалено."
    redirect_to enterprises_path
  end
end
