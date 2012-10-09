# encoding: utf-8
class FormFourReportsController < ApplicationController
  before_filter :authenticate_user!, :get_enterprise
  before_filter :check_activation, except: [:index,:show]
  
  def index
    @form_four_reports=FormFourReport.FormFourEnterpriseFor(params[:enterprise_id]).Sorted.paginate(page: params[:page])
    @OrgName=@enterprise.org_name
  end
  
  def show
    @form_four_report=FormFourReport.find(params[:id])    
    @OrgName=@enterprise.org_name
    @DatePeriod_beg=@form_four_report.date_period_beg
    @DatePeriod_end=@form_four_report.date_period_end
    @DatePeriod_beg_g4=(@DatePeriod_beg).prev_year
    @DatePeriod_end_g4=(@DatePeriod_end).prev_year
    @form_four_report_g4=FormFourReport.where(["enterprise_id=? AND date_period_beg=? AND date_period_end=?",
                  params[:enterprise_id],@DatePeriod_beg_g4,@DatePeriod_end_g4]).first # запись с данными за аналогичный период предыдущего года.
  end
  
  def new
    @form_four_report=@enterprise.form_four_reports.build
    @OrgName=@enterprise.org_name    
  end
  
  def create
    @form_four_report=@enterprise.form_four_reports.build(params[:form_four_report])
    if @form_four_report.save
      flash[:notice]="Отчёт создан."
      redirect_to enterprise_form_four_reports_path(@enterprise)
    else
      render('new')
    end
  end
  
  def edit
    @form_four_report=@enterprise.form_four_reports.find_by_id(params[:id])
    @OrgName=@enterprise.org_name    
  end

  def update
    @form_four_report=@enterprise.form_four_reports.find_by_id(params[:id])
    if @form_four_report.update_attributes(params[:form_four_report])
      flash[:notice]="Отчёт обновлен."
      redirect_to enterprise_form_four_report_path(@enterprise)
    else  
      render('edit')
    end
  end
  
  def delete
    @form_four_report=FormFourReport.find(params[:id])
  end
    
  def destroy    
    @form_four_report=@enterprise.form_four_reports.find_by_id(params[:id])
    @form_four_report.destroy
    flash[:notice]="Отчёт удалён."
    redirect_to enterprise_form_four_reports_path
  end
  
  private
  def get_enterprise
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])    
  end
end