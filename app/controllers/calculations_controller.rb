# encoding: utf-8
class CalculationsController < ApplicationController
  before_filter :authenticate_user!
  
  # здесь параметры берём из формата ?id=N, а не из пути RESTFull архитектуры resourse/N/action/...   
  def prompt    
    @enterprise=Enterprise.find_by_id(params[:id])
  end
  
  def run
    #######################################################################################
    # 1 - считаем показатели на основе формы 1 (баланса)
    @enterprise=Enterprise.find_by_id(params[:id])
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
                                        K3:     form_one_report.S300!=0?((form_one_report.S690+form_one_report.S590).to_f/form_one_report.S300):0)
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
    #######################################################################################    
    # 3 - считаем массив аналитического баланса за данный период.
    # Подготовим исходные массивы. 
    # Предприятие уже есть - @enterprise, 
    # Формы баланса на начало и конец возьмём из упорядоченной по дате коллекции записей 
    # @form_one_reports с помощью методов first и last
    @f1_beg=@form_one_reports.first
    @f1_end=@form_one_reports.last
    # В интервале дат должны иметься отчёты!))
    unless @f1_beg.nil? and @f1_end.nil? 
      # Почистим целевую таблицу от предыдущего аналогичного расчёта
      AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).delete_all

      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 0, G1: "Активы")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 1, G1: "Раздел I. ДОЛГОСРОЧНЫЕ АКТИВЫ")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Основные средства",G2: "110", 
                                              G3: @f1_beg.S110, G4: (@f1_beg.S110.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S110, G6: (@f1_end.S110.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Нематериальные активы",G2: "120", 
                                              G3: @f1_beg.S120, G4: (@f1_beg.S120.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S120, G6: (@f1_end.S120.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 3, G1: "Доходные вложения в материальные активы",G2: "130", 
                                              G3: @f1_beg.S130, G4: (@f1_beg.S130.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S130, G6: (@f1_end.S130.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 4, G1: "В том числе:")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- инвестиционная недвижимость",G2: "131", 
                                              G3: @f1_beg.S131, G4: (@f1_beg.S131.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S131, G6: (@f1_end.S131.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- предметы финансовой аренды (лизинга)",G2: "132", 
                                              G3: @f1_beg.S132, G4: (@f1_beg.S132.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S132, G6: (@f1_end.S132.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- прочие доходные вложения в материальные активы",G2: "133", 
                                              G3: @f1_beg.S133, G4: (@f1_beg.S133.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S133, G6: (@f1_end.S133.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Вложения в долгосрочные активы",G2: "140", 
                                              G3: @f1_beg.S140, G4: (@f1_beg.S140.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S140, G6: (@f1_end.S140.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Долгосрочные финансовые вложения",G2: "150", 
                                              G3: @f1_beg.S150, G4: (@f1_beg.S150.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S150, G6: (@f1_end.S150.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Отложенные налоговые активы",G2: "160", 
                                              G3: @f1_beg.S160, G4: (@f1_beg.S160.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S160, G6: (@f1_end.S160.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Долгосрочная дебиторская задолженность",G2: "170", 
                                              G3: @f1_beg.S170, G4: (@f1_beg.S170.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S170, G6: (@f1_end.S170.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Прочие долгосрочные активы",G2: "180", 
                                              G3: @f1_beg.S180, G4: (@f1_beg.S180.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S180, G6: (@f1_end.S180.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, G1: "ИТОГО Раздел I",G2: "190", 
                                              G3: @f1_beg.S190, G4: (@f1_beg.S190.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S190, G6: (@f1_end.S190.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 1, G1: "Раздел II. КРАТКОСРОЧНЫЕ АКТИВЫ")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 3, G1: "Запасы",G2: "210", 
                                              G3: @f1_beg.S210, G4: (@f1_beg.S210.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S210, G6: (@f1_end.S210.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 4, G1: "В том числе:")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- материалы",G2: "211", 
                                              G3: @f1_beg.S211, G4: (@f1_beg.S211.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S211, G6: (@f1_end.S211.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- животные на выращивании и откорме",G2: "212", 
                                              G3: @f1_beg.S212, G4: (@f1_beg.S212.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S212, G6: (@f1_end.S212.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- незавершенное производство",G2: "213", 
                                              G3: @f1_beg.S213, G4: (@f1_beg.S213.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S213, G6: (@f1_end.S213.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- готовая продукция и товары",G2: "214", 
                                              G3: @f1_beg.S214, G4: (@f1_beg.S214.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S214, G6: (@f1_end.S214.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- товары отгруженные",G2: "215", 
                                              G3: @f1_beg.S215, G4: (@f1_beg.S215.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S215, G6: (@f1_end.S215.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- прочие запасы",G2: "216", 
                                              G3: @f1_beg.S216, G4: (@f1_beg.S216.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S216, G6: (@f1_end.S216.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Долгосрочные активы, предназначенные для реализации",G2: "220", 
                                              G3: @f1_beg.S220, G4: (@f1_beg.S220.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S220, G6: (@f1_end.S220.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Расходы будущих периодов",G2: "230", 
                                              G3: @f1_beg.S230, G4: (@f1_beg.S230.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S230, G6: (@f1_end.S230.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Налог на добавленную стоимость по приобретенным товарам, работам, услугам",G2: "240", 
                                              G3: @f1_beg.S240, G4: (@f1_beg.S240.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S240, G6: (@f1_end.S240.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Краткосрочная дебиторская задолженность",G2: "250", 
                                              G3: @f1_beg.S250, G4: (@f1_beg.S250.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S250, G6: (@f1_end.S250.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Краткосрочные финансовые вложения",G2: "260", 
                                              G3: @f1_beg.S260, G4: (@f1_beg.S260.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S260, G6: (@f1_end.S260.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Денежные средства и их эквиваленты",G2: "270", 
                                              G3: @f1_beg.S270, G4: (@f1_beg.S270.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S270, G6: (@f1_end.S270.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Прочие краткосрочные активы",G2: "280", 
                                              G3: @f1_beg.S280, G4: (@f1_beg.S280.to_f/@f1_beg.S300)*100,
                                              G5: @f1_end.S280, G6: (@f1_end.S280.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, G1: "ИТОГО Раздел II",G2: "290", 
                                              G3: @f1_beg.S290, G4: (@f1_beg.S290.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S290, G6: (@f1_end.S290.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 7, G1: "БАЛАHС (190+290)",G2: "300", 
                                              G3: @f1_beg.S300, G4: (@f1_beg.S300.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S300, G6: (@f1_end.S300.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 0, G1: "Собственный капитал и обязательства")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 1, G1: "Раздел III. СОБСТВЕННЫЙ КАПИТАЛ")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Уставный капитал",G2: "410", 
                                              G3: @f1_beg.S410, G4: (@f1_beg.S410.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S410, G6: (@f1_end.S410.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Неоплаченная часть уставного капитала",G2: "420", 
                                              G3: @f1_beg.S420, G4: (@f1_beg.S420.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S420, G6: (@f1_end.S420.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Собственные акции (доли в уставном капитале)",G2: "430", 
                                              G3: @f1_beg.S430, G4: (@f1_beg.S430.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S430, G6: (@f1_end.S430.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Резервный капитал",G2: "440", 
                                              G3: @f1_beg.S440, G4: (@f1_beg.S440.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S440, G6: (@f1_end.S440.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Добавочный капитал",G2: "450", 
                                              G3: @f1_beg.S450, G4: (@f1_beg.S450.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S450, G6: (@f1_end.S450.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Нераспределенная прибыль (непокрытый убыток)",G2: "460", 
                                              G3: @f1_beg.S460, G4: (@f1_beg.S460.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S460, G6: (@f1_end.S460.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Чистая прибыль(убыток) отчетного года",G2: "470", 
                                              G3: @f1_beg.S470, G4: (@f1_beg.S470.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S470, G6: (@f1_end.S470.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Целевое финансирование",G2: "480", 
                                              G3: @f1_beg.S480, G4: (@f1_beg.S480.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S480, G6: (@f1_end.S480.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, G1: "ИТОГО Раздел III",G2: "490", 
                                              G3: @f1_beg.S490, G4: (@f1_beg.S490.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S490, G6: (@f1_end.S490.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 1, G1: "Раздел IV. ДОЛГОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Долгосрочные кредиты и займы",G2: "510", 
                                              G3: @f1_beg.S510, G4: (@f1_beg.S510.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S510, G6: (@f1_end.S510.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Долгосрочные обязательства по лизинговым платежам",G2: "520", 
                                              G3: @f1_beg.S520, G4: (@f1_beg.S520.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S520, G6: (@f1_end.S520.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Отложенные налоговые обязательства",G2: "530", 
                                              G3: @f1_beg.S530, G4: (@f1_beg.S530.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S530, G6: (@f1_end.S530.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Доходы будущих периодов",G2: "540", 
                                              G3: @f1_beg.S540, G4: (@f1_beg.S540.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S540, G6: (@f1_end.S540.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Резервы предстоящих платежей",G2: "550", 
                                              G3: @f1_beg.S550, G4: (@f1_beg.S550.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S550, G6: (@f1_end.S550.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Прочие долгосрочные обязательства",G2: "560", 
                                              G3: @f1_beg.S560, G4: (@f1_beg.S560.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S560, G6: (@f1_end.S560.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, G1: "ИТОГО Раздел IV",G2: "590", 
                                              G3: @f1_beg.S590, G4: (@f1_beg.S590.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S590, G6: (@f1_end.S590.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 1, G1: "Раздел V. КРАТКОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Краткосрочные кредиты и займы",G2: "610", 
                                              G3: @f1_beg.S610, G4: (@f1_beg.S610.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S610, G6: (@f1_end.S610.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Краткосрочная часть долгосрочных обязательств",G2: "620", 
                                              G3: @f1_beg.S620, G4: (@f1_beg.S620.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S620, G6: (@f1_end.S620.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 3, G1: "Краткосрочная кредиторская задолженность",G2: "630", 
                                              G3: @f1_beg.S630, G4: (@f1_beg.S630.to_f/@f1_beg.S700)*100,
                                              G5: @f1_end.S630, G6: (@f1_end.S630.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 4, G1: "В том числе:")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- поставщикам, подрядчикам, исполнителям",G2: "631", 
                                              G3: @f1_beg.S631, G4: (@f1_beg.S631.to_f/@f1_beg.S700)*100,
                                              G5: @f1_end.S631, G6: (@f1_end.S631.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- по авансам полученным",G2: "632", 
                                              G3: @f1_beg.S632, G4: (@f1_beg.S632.to_f/@f1_beg.S700)*100,
                                              G5: @f1_end.S632, G6: (@f1_end.S632.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- по налогам и сборам",G2: "633", 
                                              G3: @f1_beg.S633, G4: (@f1_beg.S633.to_f/@f1_beg.S700)*100,
                                              G5: @f1_end.S633, G6: (@f1_end.S633.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- по социальному страхованию и обеспечению",G2: "634", 
                                              G3: @f1_beg.S634, G4: (@f1_beg.S634.to_f/@f1_beg.S700)*100,
                                              G5: @f1_end.S634, G6: (@f1_end.S634.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- по оплате труда",G2: "635", 
                                              G3: @f1_beg.S635, G4: (@f1_beg.S635.to_f/@f1_beg.S700)*100,
                                              G5: @f1_end.S635, G6: (@f1_end.S635.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- по лизинговым платежам",G2: "636", 
                                              G3: @f1_beg.S636, G4: (@f1_beg.S636.to_f/@f1_beg.S700)*100,
                                              G5: @f1_end.S636, G6: (@f1_end.S636.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- собственнику имущества (учредителям, участникам)",G2: "637", 
                                              G3: @f1_beg.S637, G4: (@f1_beg.S637.to_f/@f1_beg.S700)*100,
                                              G5: @f1_end.S637, G6: (@f1_end.S637.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 5, G1: "- прочим кредиторам",G2: "638", 
                                              G3: @f1_beg.S638, G4: (@f1_beg.S638.to_f/@f1_beg.S700)*100,
                                              G5: @f1_end.S638, G6: (@f1_end.S638.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Обязательства, предназначенные для реализации",G2: "640", 
                                              G3: @f1_beg.S640, G4: (@f1_beg.S640.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S640, G6: (@f1_end.S640.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Доходы будущих периодов",G2: "650", 
                                              G3: @f1_beg.S650, G4: (@f1_beg.S650.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S650, G6: (@f1_end.S650.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Резервы предстоящих платежей",G2: "660", 
                                              G3: @f1_beg.S660, G4: (@f1_beg.S660.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S660, G6: (@f1_end.S660.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 2, G1: "Прочие краткосрочные обязательства",G2: "670", 
                                              G3: @f1_beg.S670, G4: (@f1_beg.S670.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S670, G6: (@f1_end.S670.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, G1: "ИТОГО Раздел V",G2: "690", 
                                              G3: @f1_beg.S690, G4: (@f1_beg.S690.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S690, G6: (@f1_end.S690.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 7, G1: "БАЛАHС (490+590+690)",G2: "700", 
                                              G3: @f1_beg.S700, G4: (@f1_beg.S700.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S700, G6: (@f1_end.S700.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      flash[:success]="Расчёт показателей выполнен ..."
    else
      flash[:alert]="За указанный рабочий интервал дат отсутствуют данные по формам баланса. Никаких расчётов не выполнилось..."
    end   
    
    redirect_to enterprise_path(params[:id])
  end  
end