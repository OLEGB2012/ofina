# encoding: utf-8
class CalculationsController < ApplicationController
  before_filter :authenticate_user!, :get_enterprise 
    
  def prompt    
    
  end
  
  def run
    #######################################################################################
    # 1 - считаем показатели на основе формы 1 (баланса)
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
    @form_one_reports.each do |form_one_report|
      # Считаем показатели ...
      form_one_report.update_attributes(Kfnez:  form_one_report.S700!=0?((form_one_report.S490).to_f/form_one_report.S700):0,
                                        Kfzav:  form_one_report.S700!=0?((form_one_report.S590+form_one_report.S690).to_f/form_one_report.S700):0,
                                        Kdfnez: form_one_report.S300!=0?((form_one_report.S490+form_one_report.S590).to_f/form_one_report.S300):0,
                                        Kcap:   form_one_report.S490!=0?((form_one_report.S590+form_one_report.S690).to_f/form_one_report.S490):0,
                                        Kman:   form_one_report.S490!=0?((form_one_report.S490-form_one_report.S190).to_f/form_one_report.S490):0,
                                        K1:     form_one_report.S690!=0?(form_one_report.S290.to_f/form_one_report.S690):0,
                                        Kabsl:  form_one_report.S690!=0?((form_one_report.S260+form_one_report.S270).to_f/form_one_report.S690):0,
                                        Kkrl:   form_one_report.S690!=0?((form_one_report.S250+form_one_report.S260+form_one_report.S270).to_f/form_one_report.S690):0,
                                        K2:     form_one_report.S290!=0?((form_one_report.S490+form_one_report.S590-form_one_report.S190).to_f/form_one_report.S290):0, 
                                        K3:     form_one_report.S300!=0?((form_one_report.S690+form_one_report.S590).to_f/form_one_report.S300):0,
                                        Cha:    form_one_report.S190+form_one_report.S290-form_one_report.S590-form_one_report.S690)
    end
    #######################################################################################
    # 2 - считаем показатели на основе формы 2 (о прибылях и убытках) и формы 1 (баланс)
    @form_two_reports=FormTwoReport.FormTwoEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end)
    @form_two_reports.each do |form_two_report|
      
      # Показатели деловой активности
       
      # данные строки 300/графы 4 (конец предыдущего года) формы 1
      @F1_S300_G4=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_beg.prev_year.end_of_year).first.S300
      # данные строки 300/графы 3 (конец текущего периода) формы 1
      @F1_S300_G3=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_end).first.S300
      @Kobk=(@F1_S300_G4+@F1_S300_G3)!=0?(form_two_report.S010.to_f/((@F1_S300_G4+@F1_S300_G3)/2)):0 # 1.Коэфф. деловой активности.
      
      # данные строки 290/графы 4 (конец предыдущего года) формы 1      
      @F1_S290_G4=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_beg.prev_year.end_of_year).first.S290 
      # данные строки 290/графы 3 (конец текущего периода) формы 1            
      @F1_S290_G3=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_end).first.S290
      @Kobs=(@F1_S290_G4+@F1_S290_G3)!=0?(form_two_report.S010.to_f/((@F1_S290_G4+@F1_S290_G3)/2)):0 # 2.Коэфф. оборачиваемости краткосрочных активов.
      
      # данные строки 211/графы 4 (конец предыдущего года) формы 1      
      @F1_S211_G4=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_beg.prev_year.end_of_year).first.S211 
      # данные строки 211/графы 3 (конец текущего периода) формы 1            
      @F1_S211_G3=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_end).first.S211
      @Kobzs=(@F1_S211_G4+@F1_S211_G3)!=0?(form_two_report.S010.to_f/((@F1_S211_G4+@F1_S211_G3)/2)):0 # 3.Коэффициент оборачиваемости запаса сырья, материалов и полуфабрикатов.
      
      # данные строки 214/графы 4 (конец предыдущего года) формы 1      
      @F1_S214_G4=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_beg.prev_year.end_of_year).first.S214 
      # данные строки 214/графы 3 (конец текущего периода) формы 1            
      @F1_S214_G3=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_end).first.S214
      @Kobgp=(@F1_S214_G4+@F1_S214_G3)!=0?(form_two_report.S010.to_f/((@F1_S214_G4+@F1_S214_G3)/2)):0 # 4.Коэффициент оборачиваемости готовой продукции
      
      # данные строки 250/графы 4 (конец предыдущего года) формы 1      
      @F1_S250_G4=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_beg.prev_year.end_of_year).first.S250 
      # данные строки 250/графы 3 (конец текущего периода) формы 1            
      @F1_S250_G3=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_end).first.S250
      @Kobdz=(@F1_S250_G4+@F1_S250_G3)!=0?(form_two_report.S010.to_f/((@F1_S250_G4+@F1_S250_G3)/2)):0 # 5.Коэффициент оборачиваемости дебиторской задолженности 
      
      # данные строки 630/графы 4 (конец предыдущего года) формы 1      
      @F1_S630_G4=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_beg.prev_year.end_of_year).first.S630 
      # данные строки 630/графы 3 (конец текущего периода) формы 1            
      @F1_S630_G3=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_end).first.S630
      @Kobkz=(@F1_S630_G4+@F1_S630_G3)!=0?(form_two_report.S010.to_f/((@F1_S630_G4+@F1_S630_G3)/2)):0 # 6.Коэффициент оборачиваемости кредиторской задолженности
      
      # Показатели рентабельности
      
      @F2_S060=form_two_report.S060.to_f
      @F2_S010=form_two_report.S010
      @Krenprod=@F2_S010!=0?(@F2_S060/@F2_S010)*100:0 # 1.Рентабельность продаж
      
      # данные строки 300/графы 4 (конец предыдущего года) формы 1      
      @F1_S300_G4=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_beg.prev_year.end_of_year).first.S300 
      # данные строки 300/графы 3 (конец текущего периода) формы 1            
      @F1_S300_G3=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_end).first.S300
      @Krenact=(@F1_S300_G4+@F1_S300_G3)!=0?((form_two_report.S150.to_f/((@F1_S300_G4+@F1_S300_G3)/2)))*100:0 # 2.Рентабельность активов
      
      # данные строки 490/графы 4 (конец предыдущего года) формы 1      
      @F1_S490_G4=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_beg.prev_year.end_of_year).first.S490 
      # данные строки 490/графы 3 (конец текущего периода) формы 1            
      @F1_S490_G3=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(form_two_report.date_period_end).first.S490
      @Krensk=(@F1_S490_G4+@F1_S490_G3)!=0?((form_two_report.S210.to_f/((@F1_S490_G4+@F1_S490_G3)/2)))*100:0 # 3.Рентабельность собственного капитала
      
      @F2_S030=form_two_report.S030.to_f
      @F2_S020=form_two_report.S020
      @Krenpz =@F2_S020!=0?(@F2_S030/@F2_S020)*100:0 # 4.Рентабельность производственных затрат, составляющих себестоимость продукции, работ, услуг
       
      @F2_S060=form_two_report.S060.to_f
      @F2_S   =form_two_report.S020+form_two_report.S040+form_two_report.S050
      @Krenps =@F2_S!=0?(@F2_S060/@F2_S)*100:0 # 5.Рентабельность полной себестоимости реализованной продукции, работ, услуг 
    
      @F2_S150=form_two_report.S150.to_f
      @F2_S   =form_two_report.S020+form_two_report.S040+form_two_report.S050+form_two_report.S080+form_two_report.S110+form_two_report.S130
      @Krenor =@F2_S!=0?(@F2_S150/@F2_S)*100:0 # 6.Рентабельность общих расходов коммерческой организации
      
      @F2_S210=form_two_report.S210.to_f
      @F2_S   =form_two_report.S020+form_two_report.S040+form_two_report.S050+form_two_report.S080+form_two_report.S110+form_two_report.S130+
               form_two_report.S170+form_two_report.S200
      @Krenchp=@F2_S!=0?(@F2_S210/@F2_S)*100:0 # 7.Рентабельность расходов, обусловивших получение чистой прибыли коммерческой организации 
      
      # Закинем в строчку массива ...
      form_two_report.update_attributes(Kobk: @Kobk, Kobs: @Kobs, Kobzs: @Kobzs, Kobgp: @Kobgp, Kobdz: @Kobdz, Kobkz: @Kobkz,
          Krenprod: @Krenprod, Krenact: @Krenact, Krensk: @Krensk, Krenpz: @Krenpz, Krenps: @Krenps, Krenor: @Krenor, Krenchp: @Krenchp)
    end
      flash[:success]="Анализ за рабочий интервал дат проведён ..."
      redirect_to enterprise_path(params[:id])
  end

  private 
  # здесь параметры берём из формата ?id=N, а не из пути RESTFull архитектуры resourse/N/action/...
  def get_enterprise
    @enterprise=Enterprise.find_by_id(params[:id])
  end
  
end