# encoding: utf-8
class FormThreeReportsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_three_reports=FormThreeReport.FormThreeEnterpriseFor(params[:enterprise_id]).Sorted.paginate(page: params[:page])
    @OrgName=@enterprise.org_name
  end
  
  def show
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_three_report=FormThreeReport.find(params[:id])    
    @OrgName=@enterprise.org_name
    @DatePeriod_beg=@form_three_report.date_period_beg
    @DatePeriod_end=@form_three_report.date_period_end
  end
  
  def new
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_three_report=@enterprise.form_three_reports.build
    @OrgName=@enterprise.org_name    
  end
  
  def create
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_three_report=@enterprise.form_three_reports.build(params[:form_three_report])
    if @form_three_report.save
      flash[:notice]="Отчёт создан."
      redirect_to enterprise_form_Three_reports_path(@enterprise)
    else
      render('new')
    end
  end
  
  def edit
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_three_report=@enterprise.form_three_reports.find_by_id(params[:id])
    @OrgName=@enterprise.org_name    
  end

  def update
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_three_report=@enterprise.form_three_reports.find_by_id(params[:id])
    if @form_three_report.update_attributes(params[:form_three_report])
      flash[:notice]="Отчёт обновлен."
      redirect_to enterprise_form_three_report_path(@enterprise)
    else  
      render('edit')
    end
  end
  
  def delete
    @form_three_report=FormThreeReport.find(params[:id])
  end
    
  def destroy
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_three_report=@enterprise.form_three_reports.find_by_id(params[:id])
    @form_three_report.destroy
    flash[:notice]="Отчёт удалён."
    redirect_to enterprise_form_three_reports_path
  end
end