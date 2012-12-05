# encoding: utf-8
class EnterprisesController < ApplicationController
  before_filter :authenticate_user!
  before_filter :check_activation, except: [:index,:show]
  
  def index
    unless current_user.try(:admin?)
      @enterprises=Enterprise.UserAreaFor(current_user.id).paginate(page: params[:page])
    else
      @enterprises=Enterprise.paginate(page: params[:page])
    end  
  end
  
  def show
    @enterprise=Enterprise.find_by_id(params[:id]) 
      if not @enterprise.nil?        
#      @form_one_reports_count  =@enterprise.form_one_reports.where(["date_period>=? AND date_period<=?",@enterprise.rab_date_beg,@enterprise.rab_date_end]).count
#      @form_two_reports_count  =@enterprise.form_two_reports.where(["date_period_beg>=? AND date_period_beg<=?",@enterprise.rab_date_beg,@enterprise.rab_date_end]).count
#      @form_three_reports_count=@enterprise.form_three_reports.where(["date_period_beg>=? AND date_period_beg<=?",@enterprise.rab_date_beg,@enterprise.rab_date_end]).count
#      @form_four_reports_count =@enterprise.form_four_reports.where(["date_period_beg>=? AND date_period_beg<=?",@enterprise.rab_date_beg,@enterprise.rab_date_end]).count
      else
        redirect_to enterprises_path
      end
  end
    
  def edit
    @enterprise=Enterprise.find_by_id(params[:id])
    if @enterprise.nil?
      redirect_to enterprises_path
    end
  end
  
  def new
    @enterprise=Enterprise.new    
  end  
  
  def delete
    @enterprise=Enterprise.find_by_id(params[:id])
    if @enterprise.nil?
      redirect_to enterprises_path
    end
  end
  
  def create
    @enterprise=Enterprise.new(params[:enterprise])
    @enterprise=current_user.enterprises.build(params[:enterprise])
    if @enterprise.save
      # Введём запись об минимальном уставном капитале...
      new_nsi_min_ust_cap = NsiMinUstCap.create!(date_vvod: '2009-01-16', summa: 0)
      @enterprise.nsi_min_ust_caps << new_nsi_min_ust_cap
      flash[:notice]="Предприятие создано."
      redirect_to enterprises_path
    else
      render('new')
    end
  end
  
  def update
    @enterprise=Enterprise.find_by_id(params[:id])
    if @enterprise.nil?
      redirect_to enterprises_path
    end
    if @enterprise.update_attributes(params[:enterprise])
      flash[:notice]="Предприятие обновлено."
      redirect_to enterprise_path(@enterprise)
    else  
      render('edit')
    end
  end
  
  def destroy
    @enterprise=Enterprise.find_by_id(params[:id])
    if @enterprise.nil?
      redirect_to enterprises_path
    end
    @enterprise.destroy
    flash[:notice]="Предприятие удалено."
    redirect_to enterprises_path
  end
end