# encoding: utf-8
class EnterprisesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprises=Enterprise.UserAreaFor(current_user.id).paginate(page: params[:page])    
  end
  
  def show
    @enterprise=Enterprise.find(params[:id])
    @form_one_reports_count  =@enterprise.form_one_reports.where(["date_period>=? AND date_period<=?",Time.now.beginning_of_year,Time.now.end_of_year]).count
    @form_two_reports_count  =@enterprise.form_two_reports.where(["date_period_beg>=? AND date_period_beg<=?",Time.now.beginning_of_year,Time.now.end_of_year]).count
    @form_three_reports_count=@enterprise.form_three_reports.where(["date_period_beg>=? AND date_period_beg<=?",Time.now.beginning_of_year,Time.now.end_of_year]).count
    @form_four_reports_count =@enterprise.form_four_reports.where(["date_period_beg>=? AND date_period_beg<=?",Time.now.beginning_of_year,Time.now.end_of_year]).count
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