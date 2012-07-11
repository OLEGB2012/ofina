class FormOneReportsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:enterprise_id]).Sorted.paginate(page: params[:page])
    @OrgName=@enterprise.org_name
  end
  
  def show
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
    @form_one_report=FormOneReport.find(params[:id])    
    @OrgName=@enterprise.org_name
    @DatePeriod=@form_one_report.date_period
  end
    
  def edit
    @form_one_report=FormOneReport.find(params[:id])
  end
  
  def new
    @form_one_report=FormOneReport.new        
  end  
  
  def delete
    @form_one_report=FormOneReport.find(params[:id])
  end
  
  def create
    @form_one_report=FormOneReport.new(params[:form_one_report])
    @form_one_report=enterprise.form_one_report.build(params[:form_one_report])
    if @form_one_report.save
      flash[:notice]="Отчёт создан."
      redirect_to form_one_report_path
    else
      render('new')
    end
  end
  
  def update
    @form_one_report=FormOneReport.find(params[:id])
    if @form_one_report.update_attributes(params[:form_one_report])
      flash[:notice]="Отчёт обновлен."
      redirect_to form_one_report_path(@form_one_report)
    else  
      render('edit')
    end
  end
  
  def destroy
    form_one_report=FormOneReport.find(params[:id])
    form_one_report.destroy
    flash[:notice]="Отчёт удалён."
    redirect_to form_one_reports_path
  end
end