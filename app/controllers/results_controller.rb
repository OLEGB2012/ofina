# encoding: utf-8
class ResultsController < ApplicationController
  before_filter :authenticate_user!, :get_enterprise
  
  def index
    
  end
  
  ###########################################################################
  # Показатели финансовой устойчивости (таблично)
  def fu_table
    @FU=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
    @FU_MAX_Kdfnez=@FU.maximum(:Kdfnez)
  end
  ###########################################################################
  # Показатели ликвидности и платёжеспособности (таблично)
  def lp_table
    @LP=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")  
  end
  ###########################################################################
  # Показатели деловой активности (таблично)
  def da_table
    @DA=FormTwoReport.FormTwoEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period_end")
    @DA_MAX_Kobk =@DA.maximum(:Kobk)
    @DA_MAX_Kobs =@DA.maximum(:Kobs)
    @DA_MAX_Kobzs=@DA.maximum(:Kobzs)
    @DA_MAX_Kobgp=@DA.maximum(:Kobgp)
    @DA_MAX_Kobdz=@DA.maximum(:Kobdz)
    @DA_MAX_Kobkz=@DA.maximum(:Kobkz)
  end
  ###########################################################################
  # Показатели рентабельности (таблично)
  def ren_table
    @REN=FormTwoReport.FormTwoEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period_end")
    @REN_MAX_Krenprod=@REN.maximum(:Krenprod)
    @REN_MAX_Krenact =@REN.maximum(:Krenact)
    @REN_MAX_Krensk  =@REN.maximum(:Krensk)
    @REN_MAX_Krenpz  =@REN.maximum(:Krenpz)
    @REN_MAX_Krenps  =@REN.maximum(:Krenps)
    @REN_MAX_Krenor  =@REN.maximum(:Krenor)
    @REN_MAX_Krenchp =@REN.maximum(:Krenchp)
  end
  #########################################################№№№№№№№№№№№№№№№№№№############################################
  # Общий (таблица+графики) обработчик для анализа баланса с двумя параметрами - предприятие :id и тип анализа :ab
  def ab
    ###########################################################################
    # Для графиков ...
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
    # Для таблицы аналитического баланса ...
    @f1_beg=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(@enterprise.rab_date_beg).first
    @f1_end=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(@enterprise.rab_date_end).first
    # В интервале дат должны иметься отчёты!))
    unless @f1_beg.nil? or @f1_end.nil?
    # Почистим целевые таблицы от предыдущего аналогичного расчёта
      AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(params[:ab].to_i).destroy_all 
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).Diagram(7*params[:ab].to_i-6,7*params[:ab].to_i).destroy_all
    case params[:ab].to_i
      when 1
        @C0="Активов баланса"
        @C4="% к балансу"
        
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 3, ab_type: 1,
          G1: "ИТОГО Раздел I (Долгосрочные активы)",G2: "190", 
          G3: @f1_beg.S190, G4: (@f1_beg.S190.to_f/@f1_beg.S300)*100, 
          G5: @f1_end.S190, G6: (@f1_end.S190.to_f/@f1_end.S300)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 3, ab_type: 1,
          G1: "ИТОГО Раздел II (Краткосрочные активы)",G2: "290", 
          G3: @f1_beg.S290, G4: (@f1_beg.S290.to_f/@f1_beg.S300)*100, 
          G5: @f1_end.S290, G6: (@f1_end.S290.to_f/@f1_end.S300)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 7, ab_type: 1,
          G1: "БАЛАHС (190+290)",G2: "300", 
          G3: @f1_beg.S300, G4: (@f1_beg.S300.to_f/@f1_beg.S300)*100,
          G5: @f1_end.S300, G6: (@f1_end.S300.to_f/@f1_end.S300)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @C1="разделов Актива баланса"
#        data.S190.to_d
        unless @form_one_reports.empty?
          @Arr_ab=[["1", "Раздел I. ДОЛГОСРОЧНЫЕ АКТИВЫ", "S190","(data.S190.to_f/data.S300)*100"],
                   ["1", "Раздел II. КРАТКОСРОЧНЫЕ АКТИВЫ", "S290","(data.S290.to_f/data.S300)*100"],
                   ["1", "БАЛАHС (190+290)","S300",100]]
        end
      when 2
        @C0="Раздела I баланса (Долгосрочные активы)"
        @C4="% к итогу Раздела I"
             
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 1, ab_type: 2,
          G1: "Раздел I. ДОЛГОСРОЧНЫЕ АКТИВЫ")
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 2,
          G1: "Основные средства",G2: "110", 
          G3: @f1_beg.S110, G4: (@f1_beg.S110.to_f/@f1_beg.S190)*100, 
          G5: @f1_end.S110, G6: (@f1_end.S110.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 2,
          G1: "Нематериальные активы",G2: "120", 
          G3: @f1_beg.S120, G4: (@f1_beg.S120.to_f/@f1_beg.S190)*100,
          G5: @f1_end.S120, G6: (@f1_end.S120.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 3, ab_type: 2,
          G1: "Доходные вложения в материальные активы",G2: "130", 
          G3: @f1_beg.S130, G4: (@f1_beg.S130.to_f/@f1_beg.S190)*100,
          G5: @f1_end.S130, G6: (@f1_end.S130.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 4, ab_type: 2, 
          G1: "В том числе:")
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 2,
          G1: "- инвестиционная недвижимость",G2: "131", 
          G3: @f1_beg.S131, G4: (@f1_beg.S131.to_f/@f1_beg.S190)*100,
          G5: @f1_end.S131, G6: (@f1_end.S131.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 2,
          G1: "- предметы финансовой аренды (лизинга)",G2: "132", 
          G3: @f1_beg.S132, G4: (@f1_beg.S132.to_f/@f1_beg.S190)*100,
          G5: @f1_end.S132, G6: (@f1_end.S132.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 2,
          G1: "- прочие доходные вложения в материальные активы",G2: "133", 
          G3: @f1_beg.S133, G4: (@f1_beg.S133.to_f/@f1_beg.S190)*100,
          G5: @f1_end.S133, G6: (@f1_end.S133.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 2,
          G1: "Вложения в долгосрочные активы",G2: "140", 
          G3: @f1_beg.S140, G4: (@f1_beg.S140.to_f/@f1_beg.S190)*100, 
          G5: @f1_end.S140, G6: (@f1_end.S140.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 2,
          G1: "Долгосрочные финансовые вложения",G2: "150", 
          G3: @f1_beg.S150, G4: (@f1_beg.S150.to_f/@f1_beg.S190)*100, 
          G5: @f1_end.S150, G6: (@f1_end.S150.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 2,
          G1: "Отложенные налоговые активы",G2: "160", 
          G3: @f1_beg.S160, G4: (@f1_beg.S160.to_f/@f1_beg.S190)*100, 
          G5: @f1_end.S160, G6: (@f1_end.S160.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 2,
          G1: "Долгосрочная дебиторская задолженность",G2: "170", 
          G3: @f1_beg.S170, G4: (@f1_beg.S170.to_f/@f1_beg.S190)*100, 
          G5: @f1_end.S170, G6: (@f1_end.S170.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 2,
          G1: "Прочие долгосрочные активы",G2: "180", 
          G3: @f1_beg.S180, G4: (@f1_beg.S180.to_f/@f1_beg.S190)*100, 
          G5: @f1_end.S180, G6: (@f1_end.S180.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 6, ab_type: 2,
          G1: "ИТОГО Раздел I",G2: "190", 
          G3: @f1_beg.S190, G4: (@f1_beg.S190.to_f/@f1_beg.S190)*100, 
          G5: @f1_end.S190, G6: (@f1_end.S190.to_f/@f1_end.S190)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @C1="строк Раздела I"
        
        unless @form_one_reports.empty?          
          @Arr_ab=[["8", "Основные средства", "S110","(data.S110.to_f/data.S190)*100"],
                   ["8", "Нематериальные активы", "S120","(data.S120.to_f/data.S190)*100"],
                   ["8", "Доходные вложения в матер-ые активы", "S130","(data.S130.to_f/data.S190)*100"],
                   ["8", "Вложения в долгосрочные активы", "S140","(data.S140.to_f/data.S190)*100"],
                   ["8", "Долгосрочные финансовые вложения", "S150","(data.S150.to_f/data.S190)*100"],
                   ["8", "Отложенные налоговые активы", "S160","(data.S160.to_f/data.S190)*100"],
                   ["8", "Долгосрочная дебиторская задол-сть", "S170","(data.S170.to_f/data.S190)*100"],
                   ["8", "Прочие долгосрочные активы", "S180","(data.S180.to_f/data.S190)*100"],
                   ["8", "ИТОГО Раздел I", "S190",100]]
        end
      when 3
        @C0="Раздела II баланса (Краткосрочные активы)"
        @C4="% к итогу Раздела II"
       
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 1, ab_type: 3,
          G1: "Раздел II. КРАТКОСРОЧНЫЕ АКТИВЫ")
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 3, ab_type: 3,
          G1: "Запасы",G2: "210", 
          G3: @f1_beg.S210, G4: (@f1_beg.S210.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S210, G6: (@f1_end.S210.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 4, ab_type: 3,
          G1: "В том числе:")
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 3,
          G1: "- материалы",G2: "211", 
          G3: @f1_beg.S211, G4: (@f1_beg.S211.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S211, G6: (@f1_end.S211.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 3,
          G1: "- животные на выращивании и откорме",G2: "212", 
          G3: @f1_beg.S212, G4: (@f1_beg.S212.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S212, G6: (@f1_end.S212.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 3,
          G1: "- незавершенное производство",G2: "213", 
          G3: @f1_beg.S213, G4: (@f1_beg.S213.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S213, G6: (@f1_end.S213.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 3,
          G1: "- готовая продукция и товары",G2: "214", 
          G3: @f1_beg.S214, G4: (@f1_beg.S214.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S214, G6: (@f1_end.S214.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 3,
          G1: "- товары отгруженные",G2: "215", 
          G3: @f1_beg.S215, G4: (@f1_beg.S215.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S215, G6: (@f1_end.S215.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 3,
          G1: "- прочие запасы",G2: "216", 
          G3: @f1_beg.S216, G4: (@f1_beg.S216.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S216, G6: (@f1_end.S216.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 3,
          G1: "Долгосрочные активы для реал.",G2: "220", 
          G3: @f1_beg.S220, G4: (@f1_beg.S220.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S220, G6: (@f1_end.S220.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 3,
          G1: "Расходы будущих периодов",G2: "230", 
          G3: @f1_beg.S230, G4: (@f1_beg.S230.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S230, G6: (@f1_end.S230.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 3,
          G1: "НДС по приобретённым ТРУ",G2: "240", 
          G3: @f1_beg.S240, G4: (@f1_beg.S240.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S240, G6: (@f1_end.S240.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 3,
          G1: "Краткосрочная дебиторская задолженность",G2: "250", 
          G3: @f1_beg.S250, G4: (@f1_beg.S250.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S250, G6: (@f1_end.S250.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 3,
          G1: "Краткосрочные финансовые вложения",G2: "260", 
          G3: @f1_beg.S260, G4: (@f1_beg.S260.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S260, G6: (@f1_end.S260.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 3,
          G1: "Денежные средства и их эквиваленты",G2: "270", 
          G3: @f1_beg.S270, G4: (@f1_beg.S270.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S270, G6: (@f1_end.S270.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 3,
          G1: "Прочие краткосрочные активы",G2: "280", 
          G3: @f1_beg.S280, G4: (@f1_beg.S280.to_f/@f1_beg.S290)*100,
          G5: @f1_end.S280, G6: (@f1_end.S280.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 6, ab_type: 3,
          G1: "ИТОГО Раздел II",G2: "290", 
          G3: @f1_beg.S290, G4: (@f1_beg.S290.to_f/@f1_beg.S290)*100, 
          G5: @f1_end.S290, G6: (@f1_end.S290.to_f/@f1_end.S290)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @C1="строк Раздела II"
       
        unless @form_one_reports.empty?
            @Arr_ab=[["15", "Запасы", "S210","(data.S210.to_f/data.S290)*100"],
                     ["15", "Долгосрочные активы для реал.", "S220","(data.S220.to_f/data.S290)*100"],
                     ["15", "Расходы будущих периодов", "S230","(data.S230.to_f/data.S290)*100"],
                     ["15", "НДС по приобретённым ТРУ", "S240","(data.S240.to_f/data.S290)*100"],
                     ["15", "Краткоср-ая дебит-ая задол-сть", "S250","(data.S250.to_f/data.S290)*100"],
                     ["15", "Краткоср-ые фин. вложения", "S260","(data.S260.to_f/data.S290)*100"],
                     ["15", "Денежные сред-ва и их эквив-ты", "S270","(data.S270.to_f/data.S290)*100"],
                     ["15", "Прочие краткосрочные активы", "S280","(data.S280.to_f/data.S290)*100"],
                     ["15", "ИТОГО Раздел II", "S290",100]]
        end
      when 4
        @C0="Пассивов баланса"
        @C4="% к балансу"
       
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 3, ab_type: 4,
          G1: "ИТОГО Раздел III (Собственный капитал)",G2: "490", 
          G3: @f1_beg.S490, G4: (@f1_beg.S490.to_f/@f1_beg.S700)*100, 
          G5: @f1_end.S490, G6: (@f1_end.S490.to_f/@f1_end.S700)*100)
        @enterprise.analytical_balances << @AB_new_rec

        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 3, ab_type: 4,
          G1: "ИТОГО Раздел IV (Долгосрочные обязательства)",G2: "590", 
          G3: @f1_beg.S590, G4: (@f1_beg.S590.to_f/@f1_beg.S700)*100, 
          G5: @f1_end.S590, G6: (@f1_end.S590.to_f/@f1_end.S700)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 3, ab_type: 4,
          G1: "ИТОГО Раздел V (Краткосрочные обязательства)",G2: "690", 
          G3: @f1_beg.S690, G4: (@f1_beg.S690.to_f/@f1_beg.S700)*100, 
          G5: @f1_end.S690, G6: (@f1_end.S690.to_f/@f1_end.S700)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 7, ab_type: 4,
          G1: "БАЛАHС (490+590+690)",G2: "700", 
          G3: @f1_beg.S700, G4: (@f1_beg.S700.to_f/@f1_beg.S700)*100, 
          G5: @f1_end.S700, G6: (@f1_end.S700.to_f/@f1_end.S700)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @C1="разделов Пассива баланса"
        
        unless @form_one_reports.empty?
            @Arr_ab=[["22", "Раздел III. СОБСТВЕННЫЙ КАПИТАЛ", "S490", "(data.S490.to_f/data.S700)*100"],
                     ["22", "Раздел IV. ДОЛГОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА", "S590", "(data.S590.to_f/data.S700)*100"],
                     ["22", "Раздел V. КРАТКОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА", "S690", "(data.S690.to_f/data.S700)*100"],
                     ["22", "БАЛАHС (490+590+690)", "S700",100]]
        end
      when 5
        @C0="Раздела III баланса (Собственный капитал)"
        @C4="% к итогу Раздела III"
       
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 1, ab_type: 5,
          G1: "Раздел III. СОБСТВЕННЫЙ КАПИТАЛ")
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 5,
          G1: "Уставный капитал",G2: "410", 
          G3: @f1_beg.S410, G4: (@f1_beg.S410.to_f/@f1_beg.S490)*100, 
          G5: @f1_end.S410, G6: (@f1_end.S410.to_f/@f1_end.S490)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 5,
          G1: "Неоплаченная часть уставного капитала",G2: "420", 
          G3: @f1_beg.S420, G4: (@f1_beg.S420.to_f/@f1_beg.S490)*100, 
          G5: @f1_end.S420, G6: (@f1_end.S420.to_f/@f1_end.S490)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 5,
          G1: "Собственные акции (доли в уставном капитале)",G2: "430", 
          G3: @f1_beg.S430, G4: (@f1_beg.S430.to_f/@f1_beg.S490)*100, 
          G5: @f1_end.S430, G6: (@f1_end.S430.to_f/@f1_end.S490)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 5,
          G1: "Резервный капитал",G2: "440", 
          G3: @f1_beg.S440, G4: (@f1_beg.S440.to_f/@f1_beg.S490)*100, 
          G5: @f1_end.S440, G6: (@f1_end.S440.to_f/@f1_end.S490)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 5,
          G1: "Добавочный капитал",G2: "450", 
          G3: @f1_beg.S450, G4: (@f1_beg.S450.to_f/@f1_beg.S490)*100, 
          G5: @f1_end.S450, G6: (@f1_end.S450.to_f/@f1_end.S490)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 5,
          G1: "Нераспределенная прибыль (непокрытый убыток)",G2: "460", 
          G3: @f1_beg.S460, G4: (@f1_beg.S460.to_f/@f1_beg.S490)*100, 
          G5: @f1_end.S460, G6: (@f1_end.S460.to_f/@f1_end.S490)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 5,
          G1: "Чистая прибыль(убыток) отчетного года",G2: "470", 
          G3: @f1_beg.S470, G4: (@f1_beg.S470.to_f/@f1_beg.S490)*100, 
          G5: @f1_end.S470, G6: (@f1_end.S470.to_f/@f1_end.S490)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 5,
          G1: "Целевое финансирование",G2: "480", 
          G3: @f1_beg.S480, G4: (@f1_beg.S480.to_f/@f1_beg.S490)*100, 
          G5: @f1_end.S480, G6: (@f1_end.S480.to_f/@f1_end.S490)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 6, ab_type: 5,
          G1: "ИТОГО Раздел III",G2: "490", 
          G3: @f1_beg.S490, G4: (@f1_beg.S490.to_f/@f1_beg.S490)*100, 
          G5: @f1_end.S490, G6: (@f1_end.S490.to_f/@f1_end.S490)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @C1="строк Раздела III"
        
        unless @form_one_reports.empty?
           @Arr_ab=[["29", "Уставный капитал", "S410", "(data.S410.to_f/data.S490)*100"],
                    ["29", "Неоплаченная часть уставного кап-ла", "S420", "(data.S420.to_f/data.S490)*100"],
                    ["29", "Собственные акции (доли в уст.кап.)", "S430", "(data.S430.to_f/data.S490)*100"],
                    ["29", "Резервный капитал", "S440", "(data.S440.to_f/data.S490)*100"],
                    ["29", "Добавочный капитал", "S450", "(data.S450.to_f/data.S490)*100"],
                    ["29", "Нераспред-ная прибыль/непокр.убыт", "S460", "(data.S460.to_f/data.S490)*100"],
                    ["29", "Чист. прибыль/уб-к отчетного года", "S470", "(data.S470.to_f/data.S490)*100"],
                    ["29", "Целевое финансирование", "S480", "(data.S480.to_f/data.S490)*100"],
                    ["29","ИТОГО Раздел III","S490",100]]
        end
      when 6
        @C0="Раздела IV баланса (Долгосрочные обязательства)"
        @C4="% к итогу Раздела IV"
       
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 1, ab_type: 6,
          G1: "Раздел IV. ДОЛГОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА")
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 6,
          G1: "Долгосрочные кредиты и займы",G2: "510", 
          G3: @f1_beg.S510, G4: (@f1_beg.S510.to_f/@f1_beg.S590)*100, 
          G5: @f1_end.S510, G6: (@f1_end.S510.to_f/@f1_end.S590)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 6,
          G1: "Долгосрочные обязательства по лизинговым платежам",G2: "520", 
          G3: @f1_beg.S520, G4: (@f1_beg.S520.to_f/@f1_beg.S590)*100, 
          G5: @f1_end.S520, G6: (@f1_end.S520.to_f/@f1_end.S590)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 6,
          G1: "Отложенные налоговые обязательства",G2: "530", 
          G3: @f1_beg.S530, G4: (@f1_beg.S530.to_f/@f1_beg.S590)*100, 
          G5: @f1_end.S530, G6: (@f1_end.S530.to_f/@f1_end.S590)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 6,
          G1: "Доходы будущих периодов",G2: "540", 
          G3: @f1_beg.S540, G4: (@f1_beg.S540.to_f/@f1_beg.S590)*100, 
          G5: @f1_end.S540, G6: (@f1_end.S540.to_f/@f1_end.S590)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 6,
          G1: "Резервы предстоящих платежей",G2: "550", 
          G3: @f1_beg.S550, G4: (@f1_beg.S550.to_f/@f1_beg.S590)*100, 
          G5: @f1_end.S550, G6: (@f1_end.S550.to_f/@f1_end.S590)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 6,
          G1: "Прочие долгосрочные обязательства",G2: "560", 
          G3: @f1_beg.S560, G4: (@f1_beg.S560.to_f/@f1_beg.S590)*100, 
          G5: @f1_end.S560, G6: (@f1_end.S560.to_f/@f1_end.S590)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 6, ab_type: 6,
          G1: "ИТОГО Раздел IV",G2: "590", 
          G3: @f1_beg.S590, G4: (@f1_beg.S590.to_f/@f1_beg.S590)*100, 
          G5: @f1_end.S590, G6: (@f1_end.S590.to_f/@f1_end.S590)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @C1="строк Раздела IV"
        
        unless @form_one_reports.empty?              
              @Arr_ab=[["36", "Долгосрочные кредиты и займы", "S510", "(data.S510.to_f/data.S590)*100"],
                       ["36", "Долгосрочные обяз-ва по лизинг.плат-м", "S520", "(data.S520.to_f/data.S590)*100"],
                       ["36", "Отложенные налоговые обяз-ства", "S530", "(data.S530.to_f/data.S590)*100"],
                       ["36", "Доходы будущих периодов", "S540", "(data.S540.to_f/data.S590)*100"],
                       ["36", "Резервы предстоящих платежей", "S550", "(data.S550.to_f/data.S590)*100"],
                       ["36", "Прочие долгосрочные обязательства", "S560", "(data.S560.to_f/data.S590)*100"],
                       ["36", "ИТОГО Раздел IV", "S590",100]]
        end
      when 7
        @C0="Раздела V баланса (Краткосрочные обязательства)"
        @C4="% к итогу Раздела V"
        
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 1, ab_type: 7,
          G1: "Раздел V. КРАТКОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА")
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 7,
          G1: "Краткосрочные кредиты и займы",G2: "610", 
          G3: @f1_beg.S610, G4: (@f1_beg.S610.to_f/@f1_beg.S690)*100, 
          G5: @f1_end.S610, G6: (@f1_end.S610.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 7,
          G1: "Краткосрочная часть долгосрочных обязательств",G2: "620", 
          G3: @f1_beg.S620, G4: (@f1_beg.S620.to_f/@f1_beg.S690)*100, 
          G5: @f1_end.S620, G6: (@f1_end.S620.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 3, ab_type: 7,
          G1: "Краткосрочная кредиторская задолженность",G2: "630", 
          G3: @f1_beg.S630, G4: (@f1_beg.S630.to_f/@f1_beg.S690)*100,
          G5: @f1_end.S630, G6: (@f1_end.S630.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 4, ab_type: 7,
          G1: "В том числе:")
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 7,
          G1: "- поставщикам, подрядчикам, исполнителям",G2: "631", 
          G3: @f1_beg.S631, G4: (@f1_beg.S631.to_f/@f1_beg.S690)*100,
          G5: @f1_end.S631, G6: (@f1_end.S631.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 7,
          G1: "- по авансам полученным",G2: "632", 
          G3: @f1_beg.S632, G4: (@f1_beg.S632.to_f/@f1_beg.S690)*100,
          G5: @f1_end.S632, G6: (@f1_end.S632.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 7,
          G1: "- по налогам и сборам",G2: "633", 
          G3: @f1_beg.S633, G4: (@f1_beg.S633.to_f/@f1_beg.S690)*100,
          G5: @f1_end.S633, G6: (@f1_end.S633.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 7,
          G1: "- по социальному страхованию и обеспечению",G2: "634", 
          G3: @f1_beg.S634, G4: (@f1_beg.S634.to_f/@f1_beg.S690)*100,
          G5: @f1_end.S634, G6: (@f1_end.S634.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 7,
          G1: "- по оплате труда",G2: "635", 
          G3: @f1_beg.S635, G4: (@f1_beg.S635.to_f/@f1_beg.S690)*100,
          G5: @f1_end.S635, G6: (@f1_end.S635.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 7,
          G1: "- по лизинговым платежам",G2: "636", 
          G3: @f1_beg.S636, G4: (@f1_beg.S636.to_f/@f1_beg.S690)*100,
          G5: @f1_end.S636, G6: (@f1_end.S636.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 7,
          G1: "- собственнику имущества (учредителям, участникам)",G2: "637", 
          G3: @f1_beg.S637, G4: (@f1_beg.S637.to_f/@f1_beg.S690)*100,
          G5: @f1_end.S637, G6: (@f1_end.S637.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 7,
          G1: "- прочим кредиторам",G2: "638", 
          G3: @f1_beg.S638, G4: (@f1_beg.S638.to_f/@f1_beg.S690)*100,
          G5: @f1_end.S638, G6: (@f1_end.S638.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 7,
          G1: "Обязательства, предназначенные для реализации",G2: "640", 
          G3: @f1_beg.S640, G4: (@f1_beg.S640.to_f/@f1_beg.S690)*100, 
          G5: @f1_end.S640, G6: (@f1_end.S640.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 7,
          G1: "Доходы будущих периодов",G2: "650", 
          G3: @f1_beg.S650, G4: (@f1_beg.S650.to_f/@f1_beg.S690)*100, 
          G5: @f1_end.S650, G6: (@f1_end.S650.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 7,
          G1: "Резервы предстоящих платежей",G2: "660", 
          G3: @f1_beg.S660, G4: (@f1_beg.S660.to_f/@f1_beg.S690)*100, 
          G5: @f1_end.S660, G6: (@f1_end.S660.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 7,
          G1: "Прочие краткосрочные обязательства",G2: "670", 
          G3: @f1_beg.S670, G4: (@f1_beg.S670.to_f/@f1_beg.S690)*100, 
          G5: @f1_end.S670, G6: (@f1_end.S670.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 6, ab_type: 7,
          G1: "ИТОГО Раздел V",G2: "690", 
          G3: @f1_beg.S690, G4: (@f1_beg.S690.to_f/@f1_beg.S690)*100, 
          G5: @f1_end.S690, G6: (@f1_end.S690.to_f/@f1_end.S690)*100)
        @enterprise.analytical_balances << @AB_new_rec
      
        @C1="строк Раздела V"
        unless @form_one_reports.empty?         
           @Arr_ab=[["43", "Краткоср-ые кредиты и займы", "S610", "(data.S610.to_f/data.S690)*100"],
                    ["43", "Краткоср-ая ч-ть долгосрочных обяз-тв", "S620", "(data.S620.to_f/data.S690)*100"],
                    ["43", "Краткоср-ая кредиторская задолж-ть", "S630", "(data.S630.to_f/data.S690)*100"],
                    ["43", "Обязательств,предназ-ые для реал-ции", "S640", "(data.S640.to_f/data.S690)*100"],
                    ["43", "Доходы будущих периодов", "S650", "(data.S650.to_f/data.S690)*100"],
                    ["43", "Резервы предстоящих платежей", "S660", "(data.S660.to_f/data.S690)*100"],
                    ["43", "Прочие краткоср-ые обяз-ства", "S670", "(data.S670.to_f/data.S690)*100"],
                    ["43", "ИТОГО Раздел V", "S690",100]]
        end
      end # от case
      # Читаем расчёты из таблицы аналитического баланса ...
      @AB=AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(params[:ab].to_i).order('id')
      # Разложим массивы по таблицам для каждого вида диаграмм ...
      @Arr_ab.each do |x|
        # Готовим массив для :line_chart-графика Динамика значений за интервал. (для горизонтального анализа)
        #
        eval("@BR_new_rec=BalanseRow.create!(date_period_beg: @f1_beg.date_period, 
                                     date_period_end: @f1_end.date_period, 
                                     diag_type: #{x[0]}, 
                                     name: "+'"'+"#{x[1]}"+'"'+")
                @BR_rec=@enterprise.balanse_rows << @BR_new_rec
                @form_one_reports.each do |data|
                   @BV_new_rec=@BR_rec.last.balanse_values.create!(date_period: data.date_period,summa: data.#{x[2]}) 
                end
                @DiagType1_data  =BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{x[0]}).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).order("+'"'+"id"+'"'+").all
                @DiagType1_series=@DiagType1_data.map{|w|w.balanse_values}")
      end
      @Arr_ab.each do |x|
        # Готовим массив для :line_chart-графика Динамика структуры за интервал. (для вертикального анализа)
        #
        unless x[3]==100 # итоговую строку надо выкинуть
        eval("@BR_new_rec=BalanseRow.create!(date_period_beg: @f1_beg.date_period, 
                                     date_period_end: @f1_end.date_period, 
                                     diag_type: 7*params[:ab].to_i-2, # это пятый график в цепочке ...
                                     name: "+'"'+"#{x[1]}"+'"'+")
                @BR_rec=@enterprise.balanse_rows << @BR_new_rec
                @form_one_reports.each do |data|
                  
                   @BV_new_rec=@BR_rec.last.balanse_values.create!(date_period: data.date_period,summa_dec: #{x[3]}) 
                  
                end
                @DiagType5_data  =BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(7*params[:ab].to_i-2).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).order("+'"'+"id"+'"'+").all
                @DiagType5_series=@DiagType5_data.map{|w|w.balanse_values}")
        end
      end
      ######################################################
      # Готовим массивы для графиков горизонтального анализа
      @AB.each do |ab|
        if (ab.row_type==2 or ab.row_type==3 or ab.row_type==5 or ab.row_type==6 or ab.row_type==7)   # Пропустим строку-заголовок раздела и строку "В том числе:"
        #  для :bar_chart-графика Изменение значений за интервал.
        #      
          @BR_new_rec=BalanseRow.create!(date_period_beg: @f1_beg.date_period, 
                                         date_period_end: @f1_end.date_period, 
                                         diag_type: 7*params[:ab].to_i-5, 
                                         name: ab.G1,
                                         summa: ab.G7)
          @BR_rec=@enterprise.balanse_rows << @BR_new_rec
         end
       end
      @AB.each do |ab|
        if (ab.row_type==2 or ab.row_type==3 or ab.row_type==5 or ab.row_type==6 or ab.row_type==7)   # Пропустим строку-заголовок раздела и строку "В том числе:"     
        # для :bar_chart-графика Темп роста значений за интервал.
        #
          @BR_new_rec=BalanseRow.create!(date_period_beg: @f1_beg.date_period, 
                                         date_period_end: @f1_end.date_period, 
                                         diag_type: 7*params[:ab].to_i-4, 
                                         name: ab.G1,
                                         summa_dec: ab.G9)
          @BR_rec=@enterprise.balanse_rows << @BR_new_rec  
         end
       end   
      @AB.each do |ab|
        if  (ab.row_type==2 or ab.row_type==3 or ab.row_type==5 or ab.row_type==6 or ab.row_type==7)   # Пропустим строку-заголовок раздела и строку "В том числе:"
        # :bar_chart-графика Темп прироста значений за интервал.
        #
          @BR_new_rec=BalanseRow.create!(date_period_beg: @f1_beg.date_period, 
                                         date_period_end: @f1_end.date_period, 
                                         diag_type: 7*params[:ab].to_i-3, 
                                         name: ab.G1,
                                         summa_dec: ab.G10)
          @BR_rec=@enterprise.balanse_rows << @BR_new_rec
         end
       end
      # Готовим массивы для графиков вертикального анализа 
      @AB.each do |ab|
        # только по строкам с данными (обычная и с итогом по группе без итогов раздела/баланса)
        if (ab.row_type==2 or ab.row_type==3 or ab.row_type==5)
          # Готовим массив для :bar_chart-графика Изменение удельного веса за интервал.
          #
          @BR_new_rec=BalanseRow.create!(date_period_beg: @f1_beg.date_period, 
                                         date_period_end: @f1_end.date_period, 
                                         diag_type: 7*params[:ab].to_i-1, 
                                         name: ab.G1,
                                         summa_dec: ab.G8)
          @BR_rec=@enterprise.balanse_rows << @BR_new_rec
        end
      end
      @DiagType2_data=BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(7*params[:ab].to_i-5).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).order("id").all
      @DiagType3_data=BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(7*params[:ab].to_i-4).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).order("id").all
      @DiagType4_data=BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(7*params[:ab].to_i-3).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).order("id").all
      @DiagType6_data=BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(7*params[:ab].to_i-1).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).order("id").all

      # Круговые диаграммы по датам ...
      unless @form_one_reports.empty?      
         @form_one_reports.each do |data|              
            @Arr_ab.each do |x|
            # Готовим массив для :pie_chart-графика Удельные веса на дату. (для вертикального анализа)
            #
            unless x[3]==100 # итоговую строку надо выкинуть       
               @BR_new_rec=BalanseRow.create!(date_period_beg: data.date_period, 
                                              date_period_end: data.date_period, 
                                              diag_type: 7*params[:ab].to_i, 
                                              name: x[1],
                                              summa: eval("data.#{x[2]}")==0?1:eval("data.#{x[2]}"))  # в "пироге" удельные веса сами считаются
                                              # 1 - эта фича важна, чтобы цвета одинаково выбирались для одних и тех же сегментов диаграммы...
               @BR_rec=@enterprise.balanse_rows << @BR_new_rec
               eval("@DiagType_#{7*params[:ab].to_i}_#{data.date_period.to_s.gsub("-","_")}_data=
                            BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{7*params[:ab].to_i}).
                               WorkPeriod(data.date_period,data.date_period).order("+'"'+"id"+'"'+").all")
               eval("@Dates=BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{7*params[:ab].to_i}).
                               WorkPeriod(@enterprise.rab_date_beg,data.date_period).order("+'"'+"date_period_end"+'"'+").
                                 select("+'"'+"date_period_end"+'"'+").group("+'"'+"date_period_end"+'"'+")")
            end
          end
        end
        # массив для хранения наборов данных для круговых диаграмм: каждый элемент - массив полей на определённую дату...
        @Arr_data=Array.new
        # для хранения айдишников для диаграмм по датам: каждый элемент - для конкретной даты ...  
        @Arr_data_id=Array.new
      end      
    else  # unless @f1_beg.nil? or @f1_end.nil?
      wrong_data_message
      redirect_to enterprise_path(params[:id])
    end
  end # def ab
  ###########################################################################
  # Показатели финансовой устойчивости (графики) из формы 1 баланса
  def fu_graph
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
    #######################################################################################
    # 1 - сформируем массив для рисования линейчатых диаграмм по динамике расчитанных показателей (в абсолютных значениях)...
    # Делаем, если есть отчёты-балансы по Форме 1 за период ...
    unless @form_one_reports.empty?
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 50 по 54"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(50,54).destroy_all
      # ... и заполняем ...
      # ################################################################
      @Arr_fu=[["50", "Автономия", "Kfnez"],
               ["51", "Концентрация привлеченного капитала", "Kfzav"],
               ["52", "Долгосрочная финансовая независимость", "Kdfnez"],
               ["53", "Соотношение заемных и собственных средств", "Kcap"],
               ["54", "Маневренность собственного капитала", "Kman"]]
            
      @Arr_fu.each do |x|       
        eval("@BR_new_rec=BalanseRow.create!(date_period_beg: @enterprise.rab_date_beg, 
                                     date_period_end: @enterprise.rab_date_end, 
                                     diag_type: #{x[0]}, 
                                     name: "+'"'+"#{x[1]}"+'"'+")
                @BR_rec=@enterprise.balanse_rows << @BR_new_rec
                @form_one_reports.each do |data|
                   @BV_new_rec=@BR_rec.last.balanse_values.create!(date_period: data.date_period,summa_dec: data.#{x[2]}) 
                end
                @DiagType#{x[0]}_data  =BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{x[0]}).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).all
                @DiagType#{x[0]}_series=@DiagType#{x[0]}_data.map{|w|w.balanse_values}")        
      end    
    end    
  end
  ###########################################################################
  # Показатели ликвидности и платёжеспособности (графики)
  def lp_graph
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
    #######################################################################################
    # 1 - сформируем массив для рисования линейчатых диаграмм по динамике расчитанных показателей (в абсолютных значениях)...
    # Делаем, если есть отчёты-балансы по Форме 1 за период ...
    unless @form_one_reports.empty?
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 55 по 59"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(55,59).destroy_all
      # ... и заполняем ...
      ######################################################
      @Arr_lp=[["55", "Текущая ликвидность (K1)", "K1"],
               ["56", "Абсолютная ликвидность", "Kabsl"],
               ["57", "Критическая (промежуточная) ликвидность", "Kkrl"],
               ["58", "Обеспеченность собственными оборотными средствами (K2)", "K2"],
               ["59", "Обеспеченность финансовых обязательств активами (K3)", "K3"]]
            
      @Arr_lp.each do |x|       
        eval("@BR_new_rec=BalanseRow.create!(date_period_beg: @enterprise.rab_date_beg, 
                                     date_period_end: @enterprise.rab_date_end, 
                                     diag_type: #{x[0]}, 
                                     name: "+'"'+"#{x[1]}"+'"'+")
                @BR_rec=@enterprise.balanse_rows << @BR_new_rec
                @form_one_reports.each do |data|
                   @BV_new_rec=@BR_rec.last.balanse_values.create!(date_period: data.date_period,summa_dec: data.#{x[2]}) 
                end
                @DiagType#{x[0]}_data  =BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{x[0]}).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).all
                @DiagType#{x[0]}_series=@DiagType#{x[0]}_data.map{|w|w.balanse_values}")        
      end    
    end    
  end
  ###########################################################################
  # Показатели деловой активности (графики)
  def da_graph
    @form_two_reports=FormTwoReport.FormTwoEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period_end")
    #######################################################################################
    # 1 - сформируем массив для рисования линейчатых диаграмм по динамике расчитанных показателей (в абсолютных значениях)...
    # Делаем, если есть отчёты по Форме 2 за период ...
    unless @form_two_reports.empty?
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 60 по 65"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(60,65).destroy_all
      # ... и заполняем ...
      ######################################################
      @Arr_da=[["60", "Общая оборачиваемость капитала (деловая активность)", "Kobk"],
               ["61", "Оборачиваемость оборотных средств (краткосрочных активов)", "Kobs"],
               ["62", "Оборачиваемость запаса сырья, материалов и полуфабрикатов", "Kobzs"],
               ["63", "Оборачиваемость готовой продукции", "Kobgp"],
               ["64", "Оборачиваемость дебиторской задолженности", "Kobdz"],
               ["65", "Оборачиваемость кредиторской задолженности", "Kobkz"]]
            
      @Arr_da.each do |x|       
        eval("@BR_new_rec=BalanseRow.create!(date_period_beg: @enterprise.rab_date_beg, 
                                     date_period_end: @enterprise.rab_date_end, 
                                     diag_type: #{x[0]}, 
                                     name: "+'"'+"#{x[1]}"+'"'+")
                @BR_rec=@enterprise.balanse_rows << @BR_new_rec
                @form_two_reports.each do |data|
                   @BV_new_rec=@BR_rec.last.balanse_values.create!(date_period: data.date_period_end,summa_dec: data.#{x[2]}) 
                end
                @DiagType#{x[0]}_data  =BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{x[0]}).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).all
                @DiagType#{x[0]}_series=@DiagType#{x[0]}_data.map{|w|w.balanse_values}")        
      end    
    end      
  end
  ###########################################################################
  # Показатели рентабельности (графики)
  def ren_graph
    @form_two_reports=FormTwoReport.FormTwoEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period_end")
    #######################################################################################
    # 1 - сформируем массив для рисования линейчатых диаграмм по динамике расчитанных показателей (в абсолютных значениях)...
    # Делаем, если есть отчёты по Форме 2 за период ...
    unless @form_two_reports.empty?
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 66 по 72"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(66,72).destroy_all
      # ... и заполняем ...
      ######################################################
      @Arr_ren=[["66", "Рентабельность продаж", "Krenprod"],
                ["67", "Рентабельность активов", "Krenact"],
                ["68", "Рентабельность собственного капитала", "Krensk"],
                ["69", "Рентабельность производственных затрат, составляющих себестоимость", "Krenpz"],
                ["70", "Рентабельность полной себестоимости реализованной продукции", "Krenps"],
                ["71", "Рентабельность общих расходов коммерческой организации", "Krenor"],
                ["72", "Рентабельность расходов, обусловивших получение чистой прибыли", "Krenchp"]]
            
      @Arr_ren.each do |x|       
        eval("@BR_new_rec=BalanseRow.create!(date_period_beg: @enterprise.rab_date_beg, 
                                     date_period_end: @enterprise.rab_date_end, 
                                     diag_type: #{x[0]}, 
                                     name: "+'"'+"#{x[1]}"+'"'+")
                @BR_rec=@enterprise.balanse_rows << @BR_new_rec
                @form_two_reports.each do |data|
                   @BV_new_rec=@BR_rec.last.balanse_values.create!(date_period: data.date_period_end,summa_dec: data.#{x[2]}) 
                end
                @DiagType#{x[0]}_data  =BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{x[0]}).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).all
                @DiagType#{x[0]}_series=@DiagType#{x[0]}_data.map{|w|w.balanse_values}")        
      end    
    end
  end
  
  ###########################################################################
  # Чистые активы
  def cha
  ###########################################################################
    # Для графиков ...
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
    # Для таблицы аналитического баланса ...
    @f1_beg=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(@enterprise.rab_date_beg).first
    @f1_end=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(@enterprise.rab_date_end).first
    # В интервале дат должны иметься отчёты!))
    unless @f1_beg.nil? or @f1_end.nil?
    # Почистим целевые таблицы от предыдущего аналогичного расчёта: используем таблицу аналитического баланса для хранения результатов
    # расчётов чистых активов, тип аналитического баланса =8,9,10, диаграмма типа=73 ...
      AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(8).destroy_all      
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).Diagram(73,73).destroy_all
      
      ###############################################################################################
      # Анализ формирования величины чистых активов организации ...
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 0, ab_type: 8,
        G1: "АНАЛИЗ ФОРМИРОВАНИЯ ВЕЛИЧИНЫ ЧИСТЫХ АКТИВОВ ОГАНИЗАЦИИ")
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 1, ab_type: 8,
        G1: "1.АКТИВЫ",G2: "1")
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 6, ab_type: 8,
        G1: "Долгосрочные активы",G2: "1.1", 
        G3: @f1_beg.S190, G5: @f1_end.S190)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Основные средства",G2: "1.1.1", 
        G3: @f1_beg.S110, G5: @f1_end.S110)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Нематериальные активы",G2: "1.1.2", 
        G3: @f1_beg.S120, G5: @f1_end.S120)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Доходные вложения в материальные активы",G2: "1.1.3", 
        G3: @f1_beg.S130, G5: @f1_end.S130)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Вложения в долгосрочные активы",G2: "1.1.4", 
        G3: @f1_beg.S140, G5: @f1_end.S140)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Долгосрочные финансовые вложения",G2: "1.1.5", 
        G3: @f1_beg.S150, G5: @f1_end.S150)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Отложенные налоговые активы",G2: "1.1.6", 
        G3: @f1_beg.S160, G5: @f1_end.S160)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Долгосрочная дебиторская задолженность",G2: "1.1.7", 
        G3: @f1_beg.S170, G5: @f1_end.S170)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Прочие долгосрочные активы",G2: "1.1.8", 
        G3: @f1_beg.S180, G5: @f1_end.S180)
      @enterprise.analytical_balances << @AB_new_rec

      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 6, ab_type: 8,
        G1: "Краткосрочные активы",G2: "1.2", 
        G3: @f1_beg.S290, G5: @f1_end.S290)
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Запасы",G2: "1.2.1", 
        G3: @f1_beg.S210, G5: @f1_end.S210)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Долгосрочные активы для реал.",G2: "1.2.2", 
        G3: @f1_beg.S220, G5: @f1_end.S220)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Расходы будущих периодов",G2: "1.2.3", 
        G3: @f1_beg.S230, G5: @f1_end.S230)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "НДС по приобретённым ТРУ",G2: "1.2.4", 
        G3: @f1_beg.S240, G5: @f1_end.S240)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Краткосрочные финансовые вложения",G2: "1.2.6", 
        G3: @f1_beg.S260, G5: @f1_end.S260)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Денежные средства и их эквиваленты",G2: "1.2.7", 
        G3: @f1_beg.S270, G5: @f1_end.S270)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Прочие краткосрочные активы",G2: "1.2.8", 
        G3: @f1_beg.S280, G5: @f1_end.S280)
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 6, ab_type: 8,
        G1: "АКТИВЫ, ПРИНИМАЕМЫЕ К РАСЧЁТУ (Строка 1.1 + Строка 1.2)",G2: "2", 
        G3: @f1_beg.S190+@f1_beg.S290, G5: @f1_end.S190+@f1_end.S290)
      @enterprise.analytical_balances << @AB_new_rec

      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 1, ab_type: 8,
        G1: "3.ОБЯЗАТЕЛЬСТВА",G2: "3")
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 6, ab_type: 8,
        G1: "Долгосрочные обязательства",G2: "3.1", 
        G3: @f1_beg.S590, G5: @f1_end.S590)
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Долгосрочные кредиты и займы",G2: "3.1.1", 
        G3: @f1_beg.S510, G5: @f1_end.S510)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Долгосрочные обязательства по лизинговым платежам",G2: "3.1.2", 
        G3: @f1_beg.S520, G5: @f1_end.S520)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Отложенные налоговые обязательства",G2: "3.1.3", 
        G3: @f1_beg.S530, G5: @f1_end.S530)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Доходы будущих периодов",G2: "3.1.4", 
        G3: @f1_beg.S540, G5: @f1_end.S540)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Резервы предстоящих платежей",G2: "3.1.5", 
        G3: @f1_beg.S550, G5: @f1_end.S550)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Прочие долгосрочные обязательства",G2: "3.1.6", 
        G3: @f1_beg.S560, G5: @f1_end.S560)
      @enterprise.analytical_balances << @AB_new_rec
        
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 6, ab_type: 8,
        G1: "Краткосрочные обязательства",G2: "3.2", 
        G3: @f1_beg.S690, G5: @f1_end.S690)
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Краткосрочные кредиты и займы",G2: "3.2.1", 
        G3: @f1_beg.S610, G5: @f1_end.S610)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Краткосрочная часть долгосрочных обязательств",G2: "3.2.2", 
        G3: @f1_beg.S620, G5: @f1_end.S620)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Краткосрочная кредиторская задолженность",G2: "3.2.3", 
        G3: @f1_beg.S630, G5: @f1_end.S630)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Обязательства, предназначенные для реализации",G2: "3.2.4", 
        G3: @f1_beg.S640, G5: @f1_end.S640)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Доходы будущих периодов",G2: "3.2.5", 
        G3: @f1_beg.S650, G5: @f1_end.S650)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Резервы предстоящих платежей",G2: "3.2.6", 
        G3: @f1_beg.S660, G5: @f1_end.S660)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Прочие краткосрочные обязательства",G2: "3.2.7", 
        G3: @f1_beg.S670, G5: @f1_end.S670)
      @enterprise.analytical_balances << @AB_new_rec

      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 6, ab_type: 8,
        G1: "ОБЯЗАТЕЛЬСТВА, ПРИНИМАЕМЫЕ К РАСЧЁТУ (Стр. 3.1 + Стр 3.2)",G2: "4", 
        G3: @f1_beg.S590+@f1_beg.S690, G5: @f1_end.S590+@f1_end.S690)
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 3, ab_type: 8,
        G1: "СТОИМОСТЬ ЧИСТЫХ АКТИВОВ (Стр. 2 - Стр. 4)",G2: "5", 
        G3: @f1_beg.Cha, G5: @f1_end.Cha)
      @enterprise.analytical_balances << @AB_new_rec

      ##############################################################################################################
      # Анализ соотношения чистых активов с уставным капиталом и минимальным размером уставного капитала организации
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 0, ab_type: 8,
        G1: "АНАЛИЗ СООТНОШЕНИЯ ЧИСТЫХ АКТИВОВ С УСТАВНЫМ КАПИТАЛОМ И МИНИМАЛЬНЫМ РАЗМЕРОМ УСТАВНОГО КАПИТАЛА ОРГАНИЗАЦИИ")
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Стоимость чистых активов",G2: "1", 
        G3: @f1_beg.Cha, G5: @f1_end.Cha)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Уставный капитал",G2: "2", 
        G3: @f1_beg.S410, G5: @f1_end.S410)
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 6, ab_type: 8,
        G1: "Разность между чистыми активами и уставным капиталом (стр. 1 - стр. 2)",G2: "3", 
        G3: @f1_beg.Cha-@f1_beg.S410, G5: @f1_end.Cha-@f1_end.S410)
      @enterprise.analytical_balances << @AB_new_rec
      
      ######################################################################################################
      # Определим значение минимального уставного кап-ла из справочника с учётом "историзма".
      # Также проверяем на существование результата, иначе - выдаём предупреждение ...
      @nsi_min_ust_cap_beg=NsiMinUstCap.EnterpriseFor(params[:id]).Sorted.OnDate(@f1_beg.date_period).first
      @nsi_min_ust_cap_end=NsiMinUstCap.EnterpriseFor(params[:id]).Sorted.OnDate(@f1_end.date_period).first
      if not (@nsi_min_ust_cap_beg.nil? and @nsi_min_ust_cap_end.nil?)
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 2, ab_type: 8,
          G1: "Минимальный уставный капитал",G2: "4", 
          G3: @nsi_min_ust_cap_beg.summa, G5: @nsi_min_ust_cap_end.summa)
        @enterprise.analytical_balances << @AB_new_rec

        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 6, ab_type: 8,
          G1: "Разность между чистыми активами и минимальным уставным капиталом (стр. 1 - стр. 4)",G2: "5", 
          G3: @f1_beg.Cha-@nsi_min_ust_cap_beg.summa, G5: @f1_end.Cha-@nsi_min_ust_cap_end.summa)
        @enterprise.analytical_balances << @AB_new_rec
      else
        @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
          row_type: 5, ab_type: 8,
          G1: "На отчётный период не введён минимальный уставной капитал. 
               Введите его посредством Панель Управления->Справочники-> для Вашей организации...",G2: "-", 
          G3: 0, G5: 0)
        @enterprise.analytical_balances << @AB_new_rec
      end
      #########################################################################################
      # Анализ соотношения чистых активов с суммой уставного и резервного капиталов организации
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 0, ab_type: 8,
        G1: "АНАЛИЗ СООТНОШЕНИЯ ЧИСТЫХ АКТИВОВ С СУММОЙ УСТАВНОГО И РЕЗЕРВНОГО КАПИТАЛОВ ОРГАНИЗАЦИИ")
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Стоимость чистых активов",G2: "1", 
        G3: @f1_beg.Cha, G5: @f1_end.Cha)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Уставный капитал",G2: "2", 
        G3: @f1_beg.S410, G5: @f1_end.S410)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Резервный капитал",G2: "3", 
        G3: @f1_beg.S440, G5: @f1_end.S440)
      @enterprise.analytical_balances << @AB_new_rec
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 2, ab_type: 8,
        G1: "Сумма уставного и резервного капиталов (стр. 2 + стр. 3)",G2: "4", 
        G3: @f1_beg.S410+@f1_beg.S440, G5: @f1_end.S410+@f1_end.S440)
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
        row_type: 6, ab_type: 8,
        G1: "Разность между чистыми активами и суммой уставного и резервного капиталов (стр. 1 – стр. 4)",G2: "5", 
        G3: @f1_beg.Cha-@f1_beg.S410-@f1_beg.S440, G5: @f1_end.Cha-@f1_end.S410-@f1_end.S440)
      @enterprise.analytical_balances << @AB_new_rec
      
      
      unless @form_one_reports.empty?          
        @Arr_ab=[["8", "Основные средства", "S110","(data.S110.to_f/data.S190)*100"],
                 ["8", "Нематериальные активы", "S120","(data.S120.to_f/data.S190)*100"],
                 ["8", "Доходные вложения в матер-ые активы", "S130","(data.S130.to_f/data.S190)*100"],
                 ["8", "Вложения в долгосрочные активы", "S140","(data.S140.to_f/data.S190)*100"],
                 ["8", "Долгосрочные финансовые вложения", "S150","(data.S150.to_f/data.S190)*100"],
                 ["8", "Отложенные налоговые активы", "S160","(data.S160.to_f/data.S190)*100"],
                 ["8", "Долгосрочная дебиторская задол-сть", "S170","(data.S170.to_f/data.S190)*100"],
                 ["8", "Прочие долгосрочные активы", "S180","(data.S180.to_f/data.S190)*100"],
                 ["8", "ИТОГО Раздел I", "S190",100]]
      end      
      
      # Читаем расчёты из таблицы аналитического баланса ...
      @AB_8 =AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(8).order('id')      
      
    else  # unless @f1_beg.nil? or @f1_end.nil?
      wrong_data_message
      redirect_to enterprise_path(params[:id])        
    end    
  end # def cha
  
  ###############################################################################
  private
  def get_enterprise
    @enterprise=Enterprise.find_by_id(params[:id])
  end
  
  def wrong_data_message
    if @f1_beg.nil?
      flash[:alert]="На начало рабочего интервала дат нет отчёта Бухгалтерский баланс. Данные для анализа отсутствуют..."
    end
    if @f1_end.nil?
      flash[:alert]="На конец рабочего интервала дат нет отчёта Бухгалтерский баланс. Данные для анализа отсутствуют..."
    end
  end
end