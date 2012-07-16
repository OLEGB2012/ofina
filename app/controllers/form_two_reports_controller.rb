# encoding: utf-8
class FormTwoReportsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_two_reports=FormTwoReport.FormTwoEnterpriseFor(params[:enterprise_id]).Sorted.paginate(page: params[:page])
    @OrgName=@enterprise.org_name
  end
  
  def show
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_two_report=FormTwoReport.find(params[:id])    
    @OrgName=@enterprise.org_name
    @DatePeriod_beg=@form_two_report.date_period_beg
    @DatePeriod_end=@form_two_report.date_period_end
    @DatePeriod_beg_g4=(@DatePeriod_beg).prev_year
    @DatePeriod_end_g4=(@DatePeriod_end).prev_year
    @form_two_report_g4=FormTwoReport.where(["enterprise_id=? AND date_period_beg=? AND date_period_end=?",
                  params[:enterprise_id],@DatePeriod_beg_g4,@DatePeriod_end_g4]).first # запись с данными за аналогичный период предыдущего года.
  end
  
  def new
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_two_report=@enterprise.form_two_reports.build
    @OrgName=@enterprise.org_name    
  end
  
  def create
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_two_report=@enterprise.form_two_reports.build(params[:form_two_report])
    if @form_two_report.save
      flash[:notice]="Отчёт создан."
      redirect_to enterprise_form_two_reports_path(@enterprise)
    else
      render('new')
    end
  end
  
  def edit
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_two_report=@enterprise.form_two_reports.find_by_id(params[:id])
    @OrgName=@enterprise.org_name    
  end

  def update
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_two_report=@enterprise.form_two_reports.find_by_id(params[:id])
    if @form_two_report.update_attributes(params[:form_two_report])
      flash[:notice]="Отчёт обновлен."
      redirect_to enterprise_form_two_report_path(@enterprise)
    else  
      render('edit')
    end
  end
  
  def delete
    @form_two_report=FormTwoReport.find(params[:id])
  end
    
  def destroy
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_two_report=@enterprise.form_two_reports.find_by_id(params[:id])
    @form_two_report.destroy
    flash[:notice]="Отчёт удалён."
    redirect_to enterprise_form_two_reports_path
  end
end