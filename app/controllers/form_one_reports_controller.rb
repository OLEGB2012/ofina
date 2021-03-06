# encoding: utf-8
class FormOneReportsController < ApplicationController
  before_filter :authenticate_user!, :get_enterprise
  before_filter :check_activation, except: [:index,:show]
  
  def index
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:enterprise_id]).Sorted.paginate(page: params[:page])
    @OrgName=@enterprise.org_name
  end
  
  def show
    @form_one_report=FormOneReport.find(params[:id])    
    @OrgName=@enterprise.org_name
    @DatePeriod=@form_one_report.date_period
    @form_one_report_g4=FormOneReport.where(["enterprise_id=? AND date_period=?",
                  params[:enterprise_id],((@DatePeriod).prev_year).end_of_year]).first # запись с балансом на конец предыдущего года
  end
  
  def new
    @form_one_report=@enterprise.form_one_reports.build
    @OrgName=@enterprise.org_name    
  end
  
  def create
    @form_one_report=@enterprise.form_one_reports.build(params[:form_one_report])
    if @form_one_report.save
      flash[:notice]="Отчёт создан."
      redirect_to enterprise_form_one_reports_path(@enterprise)
    else
      render('new')
    end
  end
  
  def edit
    @form_one_report=@enterprise.form_one_reports.find_by_id(params[:id])
    @OrgName=@enterprise.org_name    
  end

  def update
    @form_one_report=@enterprise.form_one_reports.find_by_id(params[:id])
    if @form_one_report.update_attributes(params[:form_one_report])
      flash[:notice]="Отчёт обновлен."
      redirect_to enterprise_form_one_report_path(@enterprise)
    else  
      render('edit')
    end
  end
  
  def delete
    @form_one_report=FormOneReport.find(params[:id])
  end
    
  def destroy
    @form_one_report=@enterprise.form_one_reports.find_by_id(params[:id])
    @form_one_report.destroy
    flash[:notice]="Отчёт удалён."
    redirect_to enterprise_form_one_reports_path
  end
  
  private
  def get_enterprise
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
  end
end