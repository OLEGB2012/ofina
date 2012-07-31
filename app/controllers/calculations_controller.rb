# encoding: utf-8
class CalculationsController < ApplicationController
  before_filter :authenticate_user!
  
  # здесь параметры берём из формата ?id=N, а не из пути RESTFull архитектуры resourse/N/action/...   
  def prompt    
    @enterprise=Enterprise.find_by_id(params[:id])
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end)
  end
  
  def run
    @enterprise=Enterprise.find_by_id(params[:id])
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end)
    @form_one_reports.each do |form_one_report| 
#      @q1=(form_one_report.S290.to_f/form_one_report.S690)
#      form_one_report.update_column(:K1, @q1)
      form_one_report.update_attributes(K1: form_one_report.S690!=0?(form_one_report.S290.to_f/form_one_report.S690):0, 
                                        K2: form_one_report.S290!=0?((form_one_report.S490+form_one_report.S590-form_one_report.S190).to_f/form_one_report.S290):0, 
                                        K3: form_one_report.S300!=0?((form_one_report.S690+form_one_report.S590).to_f/form_one_report.S300):0,
                                        Kabsl: form_one_report.S690!=0?((form_one_report.S260+form_one_report.S270).to_f/form_one_report.S690):0, 
                                        Kcap:  form_one_report.S490!=0?((form_one_report.S590+form_one_report.S690).to_f/form_one_report.S490):0, 
                                        Kfnez: form_one_report.S700!=0?((form_one_report.S490).to_f/form_one_report.S700):0)
    end    
    flash[:success]="Расчёт показателей выполнен ..."
    redirect_to enterprise_path(params[:id])
  end  
end