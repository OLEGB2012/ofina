# encoding: utf-8
class ResultsController < ApplicationController
  before_filter :authenticate_user!, :check_activation, :get_enterprise
  
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
  # Общий (таблица+графики) обработчик для аналитического баланса с двумя параметрами - предприятие :id и тип анализа :ab
  def ab
  ###########################################################################
  @f1_beg=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(@enterprise.rab_date_beg).first
  @f1_end=FormOneReport.FormOneEnterpriseFor(params[:id]).ReportOnDate(@enterprise.rab_date_end).first
  # В интервале дат должны иметься отчёты!))
  unless @f1_beg.nil? and @f1_end.nil? 
    case params[:ab].to_i
    when 1
      @C0="Активов баланса"
      @C4="% к балансу"
      # Почистим целевую таблицу от предыдущего аналогичного расчёта
      AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(1).destroy_all
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, ab_type: 1,
                                              G1: "ИТОГО Раздел I (Долгосрочные активы)",G2: "190", 
                                              G3: @f1_beg.S190, G4: (@f1_beg.S190.to_f/@f1_beg.S300)*100, 
                                              G5: @f1_end.S190, G6: (@f1_end.S190.to_f/@f1_end.S300)*100)
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, ab_type: 1,
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
      # Готовим массив для графика Динамика значений за интервал.
      #
      
      # Готовим массив для графика Изменение значений за интервал.
      #
      
      # Готовим массив для графика Темп роста значений за интервал.
      #
      
      # Готовим массив для графика Темп прироста значений за интервал.
      #
      
     when 2
      @C0="Раздела I баланса (Долгосрочные активы)"
      @C4="% к итогу Раздела I"
      # Почистим целевую таблицу от предыдущего аналогичного расчёта
      AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(2).destroy_all
      
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
      # Готовим массив для графика Динамика значений за интервал.
      #
            
      # Готовим массив для графика Изменение значений за интервал.
      #
      
      # Готовим массив для графика Темп роста значений за интервал.
      #
      
      # Готовим массив для графика Темп прироста значений за интервал.
      #
      
    when 3
      @C0="Раздела II баланса (Краткосрочные активы)"
      @C4="% к итогу Раздела II"
      # Почистим целевую таблицу от предыдущего аналогичного расчёта
      AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(3).destroy_all
      
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
                                              G1: "Долгосрочные активы, предназначенные для реализации",G2: "220", 
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
                                              G1: "Налог на добавленную стоимость по приобретенным товарам, работам, услугам",G2: "240", 
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
      # Готовим массив для графика Динамика значений за интервал.
      #
            
      # Готовим массив для графика Изменение значений за интервал.
      #
      
      # Готовим массив для графика Темп роста значений за интервал.
      #
      
      # Готовим массив для графика Темп прироста значений за интервал.
      #
      
    when 4
      @C0="Пассивов баланса"
      @C4="% к балансу"
      # Почистим целевую таблицу от предыдущего аналогичного расчёта
      AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(4).destroy_all
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, ab_type: 4,
                                              G1: "ИТОГО Раздел III (Собственный капитал)",G2: "490", 
                                              G3: @f1_beg.S490, G4: (@f1_beg.S490.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S490, G6: (@f1_end.S490.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec

      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, ab_type: 4,
                                              G1: "ИТОГО Раздел IV (Долгосрочные обязательства)",G2: "590", 
                                              G3: @f1_beg.S590, G4: (@f1_beg.S590.to_f/@f1_beg.S700)*100, 
                                              G5: @f1_end.S590, G6: (@f1_end.S590.to_f/@f1_end.S700)*100)
      @enterprise.analytical_balances << @AB_new_rec
      
      @AB_new_rec = AnalyticalBalance.create!(date_period_beg: @f1_beg.date_period, date_period_end: @f1_end.date_period, 
                                              row_type: 6, ab_type: 4,
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
      # Готовим массив для графика Динамика значений за интервал.
      #
            
      # Готовим массив для графика Изменение значений за интервал.
      #
      
      # Готовим массив для графика Темп роста значений за интервал.
      #
      
      # Готовим массив для графика Темп прироста значений за интервал.
      #
      
    when 5
      @C0="Раздела III баланса (Собственный капитал)"
      @C4="% к итогу Раздела III"
      # Почистим целевую таблицу от предыдущего аналогичного расчёта
      AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(5).destroy_all
      
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
      # Готовим массив для графика Динамика значений за интервал.
      #
            
      # Готовим массив для графика Изменение значений за интервал.
      #
      
      # Готовим массив для графика Темп роста значений за интервал.
      #
      
      # Готовим массив для графика Темп прироста значений за интервал.
      #
      
    when 6
      @C0="Раздела IV баланса (Долгосрочные обязательства)"
      @C4="% к итогу Раздела IV"
      # Почистим целевую таблицу от предыдущего аналогичного расчёта
      AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(6).destroy_all
      
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
      # Готовим массив для графика Динамика значений за интервал.
      #
            
      # Готовим массив для графика Изменение значений за интервал.
      #
      
      # Готовим массив для графика Темп роста значений за интервал.
      #
      
      # Готовим массив для графика Темп прироста значений за интервал.
      #
      
    when 7
     @C0="Раздела V баланса (Краткосрочные обязательства)"
     @C4="% к итогу Раздела V"
     # Почистим целевую таблицу от предыдущего аналогичного расчёта
     AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@f1_beg.date_period,@f1_end.date_period).KindOfAB(7).destroy_all
     
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
      # Готовим массив для графика Динамика значений за интервал.
      #
            
      # Готовим массив для графика Изменение значений за интервал.
      #
      
      # Готовим массив для графика Темп роста значений за интервал.
      #
      
      # Готовим массив для графика Темп прироста значений за интервал.
      #
      
    end
  else
    if @f1_beg.nil?
      flash[:alert]="На начало рабочего интервала дат отсутствуют данные по форме баланса..."
    end
    if @f1_end.nil?
      flash[:alert]="На конец рабочего интервала дат отсутствуют данные по форме баланса..."
    end
  end
  
  # Читаем расчёты из таблицы
  @AB=AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).KindOfAB(params[:ab].to_i).order("id")
 
  ###########################################################################
  # "аля" Аналитический баланс (графики) из формы 1 баланса.
  @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
  
    #######################################################################################
    # 1 - сформируем массив для рисования линейчатых диаграмм по динамике статей баланса (в абсолютных значениях)...
    # Делаем, если есть отчёты-балансы по Форме 1 за период ...
    unless @form_one_reports.empty?
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 1 по 7"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(1,7).destroy_all
      # ... и заполняем ...
      # ################################################################
      @Arr_abs=[["1", "Раздел I. ДОЛГОСРОЧНЫЕ АКТИВЫ", "S190"],
            ["1", "Раздел II. КРАТКОСРОЧНЫЕ АКТИВЫ", "S290"],
            ["2", "Раздел III. СОБСТВЕННЫЙ КАПИТАЛ", "S490"],
            ["2", "Раздел IV. ДОЛГОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА", "S590"],
            ["2", "Раздел V. КРАТКОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА", "S690"],
            ["3", "Основные средства", "S110"],
            ["3", "Нематериальные активы", "S120"],
            ["3", "Доходные вложения в матер-ые активы", "S130"],
            ["3", "Вложения в долгосрочные активы", "S140"],
            ["3", "Долгосрочные финансовые вложения", "S150"],
            ["3", "Отложенные налоговые активы", "S160"],
            ["3", "Долгосрочная дебиторская задол-сть", "S170"],
            ["3", "Прочие долгосрочные активы", "S180"],
            ["4", "Запасы", "S210"],
            ["4", "Долгосрочные активы для реал.", "S220"],
            ["4", "Расходы будущих периодов", "S230"],
            ["4", "Налог на добавл.стоим.по приобр.ТРУ", "S240"],
            ["4", "Краткоср-ая дебит-ая задол-сть", "S250"],
            ["4", "Краткоср-ые фин. вложения", "S260"],
            ["4", "Денежные сред-ва и их эквив-ты", "S270"],
            ["4", "Прочие краткосрочные активы", "S280"],
            ["5", "Уставный капитал", "S410"],
            ["5", "Неоплаченная часть уставного кап-ла", "S420"],
            ["5", "Собственные акции (доли в уст.кап.)", "S430"],
            ["5", "Резервный капитал", "S440"],
            ["5", "Добавочный капитал", "S450"],
            ["5", "Нераспред-ная прибыль/непокр.убыт", "S460"],
            ["5", "Чист. прибыль/уб-к отчетного года", "S470"],
            ["5", "Целевое финансирование", "S480"],
            ["6", "Долгосрочные кредиты и займы", "S510"],
            ["6", "Долгосрочные обяз-ва по лизинг.плат-м", "S520"],
            ["6", "Отложенные налоговые обяз-ства", "S530"],
            ["6", "Доходы будущих периодов", "S540"],
            ["6", "Резервы предстоящих платежей", "S550"],
            ["6", "Прочие долгосрочные обязательства", "S560"],
            ["7", "Краткоср-ые кредиты и займы", "S610"],
            ["7", "Краткоср-ая ч-ть долгосрочных обяз-тв", "S620"],
            ["7", "Краткоср-ая кредиторская задолж-ть", "S630"],
            ["7", "Обязательств,предназ-ые для реал-ции", "S640"],
            ["7", "Доходы будущих периодов", "S650"],
            ["7", "Резервы предстоящих платежей", "S660"],
            ["7", "Прочие краткоср-ые обяз-ства", "S670"]]
            
      @Arr_abs.each do |x|       
          eval("@BR_new_rec=BalanseRow.create!(date_period_beg: @enterprise.rab_date_beg, 
                                     date_period_end: @enterprise.rab_date_end, 
                                     diag_type: #{x[0]}, 
                                     name: "+'"'+"#{x[1]}"+'"'+")
                @BR_rec=@enterprise.balanse_rows << @BR_new_rec
                @form_one_reports.each do |data|
                   @BV_new_rec=@BR_rec.last.balanse_values.create!(date_period: data.date_period,summa: data.#{x[2]}) 
                end
                @DiagType#{x[0]}_data  =BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{x[0]}).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).all
                @DiagType#{x[0]}_series=@DiagType#{x[0]}_data.map{|w|w.balanse_values}")        
      end    
    end
     #######################################################################################
    # 2 - сформируем массив для рисования линейчатых диаграмм по динамике статей баланса (в значениях удельных весов)...
    # Делаем, если есть отчёты-балансы по Форме 1 за период ...
    unless @form_one_reports.empty?
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 8 по 14"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(8,14).destroy_all
      # ... и заполняем ...
      # ################################################################
      @Arr_udel=[["8", "Раздел I. ДОЛГОСРОЧНЫЕ АКТИВЫ",    "(data.S190.to_f/data.S300)*100"],
            ["8", "Раздел II. КРАТКОСРОЧНЫЕ АКТИВЫ",       "(data.S290.to_f/data.S300)*100"],
            ["9", "Раздел III. СОБСТВЕННЫЙ КАПИТАЛ",       "(data.S490.to_f/data.S300)*100"],
            ["9", "Раздел IV. ДОЛГОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА", "(data.S590.to_f/data.S700)*100"],
            ["9", "Раздел V. КРАТКОСРОЧНЫЕ ОБЯЗАТЕЛЬСТВА", "(data.S690.to_f/data.S700)*100"],
            ["10", "Основные средства",                    "(data.S110.to_f/data.S300)*100"],
            ["10", "Нематериальные активы",                "(data.S120.to_f/data.S300)*100"],
            ["10", "Доходные вложения в матер-ые активы",  "(data.S130.to_f/data.S300)*100"],
            ["10", "Вложения в долгосрочные активы",       "(data.S140.to_f/data.S300)*100"],
            ["10", "Долгосрочные финансовые вложения",     "(data.S150.to_f/data.S300)*100"],
            ["10", "Отложенные налоговые активы",          "(data.S160.to_f/data.S300)*100"],
            ["10", "Долгосрочная дебиторская задол-сть",   "(data.S170.to_f/data.S300)*100"],
            ["10", "Прочие долгосрочные активы",           "(data.S180.to_f/data.S300)*100"],
            ["11", "Запасы",                               "(data.S210.to_f/data.S300)*100"],
            ["11", "Долгосрочные активы для реал.",        "(data.S220.to_f/data.S300)*100"],
            ["11", "Расходы будущих периодов",             "(data.S230.to_f/data.S300)*100"],
            ["11", "Налог на добавл.стоим.по приобр.ТРУ",  "(data.S240.to_f/data.S300)*100"],
            ["11", "Краткоср-ая дебит-ая задол-сть",       "(data.S250.to_f/data.S300)*100"],
            ["11", "Краткоср-ые фин. вложения",            "(data.S260.to_f/data.S300)*100"],
            ["11", "Денежные сред-ва и их эквив-ты",       "(data.S270.to_f/data.S300)*100"],
            ["11", "Прочие краткосрочные активы",          "(data.S280.to_f/data.S300)*100"],
            ["12", "Уставный капитал",                     "(data.S410.to_f/data.S700)*100"],
            ["12", "Неоплаченная часть уставного кап-ла",  "(data.S420.to_f/data.S700)*100"],
            ["12", "Собственные акции (доли в уст.кап.)",  "(data.S430.to_f/data.S700)*100"],
            ["12", "Резервный капитал",                    "(data.S440.to_f/data.S700)*100"],
            ["12", "Добавочный капитал",                   "(data.S450.to_f/data.S700)*100"],
            ["12", "Нераспред-ная прибыль/непокр.убыт",    "(data.S460.to_f/data.S700)*100"],
            ["12", "Чист. прибыль/уб-к отчетного года",    "(data.S470.to_f/data.S700)*100"],
            ["12", "Целевое финансирование",               "(data.S480.to_f/data.S700)*100"],
            ["13", "Долгосрочные кредиты и займы",         "(data.S510.to_f/data.S700)*100"],
            ["13", "Долгосрочные обяз-ва по лизинг.плат-м","(data.S520.to_f/data.S700)*100"],
            ["13", "Отложенные налоговые обяз-ства",       "(data.S530.to_f/data.S700)*100"],
            ["13", "Доходы будущих периодов",              "(data.S540.to_f/data.S700)*100"],
            ["13", "Резервы предстоящих платежей",         "(data.S550.to_f/data.S700)*100"],
            ["13", "Прочие долгосрочные обязательства",    "(data.S560.to_f/data.S700)*100"],
            ["14", "Краткоср-ые кредиты и займы",          "(data.S610.to_f/data.S700)*100"],
            ["14", "Краткоср-ая ч-ть долгосрочных обяз-тв","(data.S620.to_f/data.S700)*100"],
            ["14", "Краткоср-ая кредиторская задолж-ть",   "(data.S630.to_f/data.S700)*100"],
            ["14", "Обязательств,предназ-ые для реал-ции", "(data.S640.to_f/data.S700)*100"],
            ["14", "Доходы будущих периодов",              "(data.S650.to_f/data.S700)*100"],
            ["14", "Резервы предстоящих платежей",         "(data.S660.to_f/data.S700)*100"],
            ["14", "Прочие краткоср-ые обяз-ства",         "(data.S670.to_f/data.S700)*100"]]
      @Arr_udel.each do |x|       
          eval("@BR_new_rec=BalanseRow.create!(date_period_beg: @enterprise.rab_date_beg, 
                                     date_period_end: @enterprise.rab_date_end, 
                                     diag_type: #{x[0]}, 
                                     name: "+'"'+"#{x[1]}"+'"'+")
                @BR_rec=@enterprise.balanse_rows << @BR_new_rec
                @form_one_reports.each do |data|
                   @BV_new_rec=@BR_rec.last.balanse_values.create!(date_period: data.date_period,summa_dec: #{x[2]}) 
                end
                @DiagType#{x[0]}_data  =BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{x[0]}).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).all
                @DiagType#{x[0]}_series=@DiagType#{x[0]}_data.map{|w|w.balanse_values}")        
      end
      #################################################################################################
      # Готовим таблицу для круговых диаграм по тому же массиву @Arr_udel, тип - 15xxx ... и заполняем поля ...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(15000,99999).destroy_all
       @form_one_reports.each do |data|              
          @Arr_udel.each do |x|
             @nDT=x[0].to_i
             result = case @nDT
                when (10..11); 1
                when (12..14); 2
                else; 0
             end
             @nVar=15000+result             
             @BR_new_rec=BalanseRow.create!(date_period_beg: data.date_period, 
                                            date_period_end: data.date_period, 
                                            diag_type: @nVar, 
                                            name: x[1],
                                            summa: eval(x[2])==0?1:eval(x[2])*data.S300/100)  
                                            ## 1 - эта фича важна, чтобы цвета одинаково выбирались для одних и тех же сегментов диаграммы...
             @BR_rec=@enterprise.balanse_rows << @BR_new_rec
             eval("@DiagType_#{@nVar}_#{data.date_period.to_s.gsub("-","_")}_data=
                          BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{@nVar}).
                             WorkPeriod(data.date_period,data.date_period).order("+'"'+"id"+'"'+").all")
             eval("@Dates=BalanseRow.BalanseRowEnterpriseFor(params[:id]).DiagramType(#{@nVar}).
                             WorkPeriod(@enterprise.rab_date_beg,data.date_period).order("+'"'+"date_period_end"+'"'+").
                               select("+'"'+"date_period_end"+'"'+").group("+'"'+"date_period_end"+'"'+")")
          end                
      end
      # массивы для хранения наборов данных для круговых диаграмм: каждый элемент - массив полей на определённую дату...
      @Arr_act=Array.new 
      @Arr_pas=Array.new 
      # для хранения айдишников для диаграмм по датам: каждый элемент - для конкретной даты ...  
      @Arr_act_id=Array.new 
      @Arr_pas_id=Array.new  
    end
  end
  ###########################################################################
  # Показатели финансовой устойчивости (графики) из формы 1 баланса
  def fu_graph
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
    #######################################################################################
    # 1 - сформируем массив для рисования линейчатых диаграмм по динамике расчитанных показателей (в абсолютных значениях)...
    # Делаем, если есть отчёты-балансы по Форме 1 за период ...
    unless @form_one_reports.empty?
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 16 по 20"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(16,20).destroy_all
      # ... и заполняем ...
      # ################################################################
      @Arr_fu=[["16", "Автономия", "Kfnez"],
            ["17", "Концентрация привлеченного капитала", "Kfzav"],
            ["18", "Долгосрочная финансовая независимость", "Kdfnez"],
            ["19", "Соотношение заемных и собственных средств", "Kcap"],
            ["20", "Маневренность собственного капитала", "Kman"]]
            
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
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 21 по 25"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(21,25).destroy_all
      # ... и заполняем ...
      ######################################################
      @Arr_lp=[["21", "Текущая ликвидность (K1)", "K1"],
            ["22", "Абсолютная ликвидность", "Kabsl"],
            ["23", "Критическая (промежуточная) ликвидность", "Kkrl"],
            ["24", "Обеспеченность собственными оборотными средствами (K2)", "K2"],
            ["25", "Обеспеченность финансовых обязательств активами (K3)", "K3"]]
            
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
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 26 по 31"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(26,31).destroy_all
      # ... и заполняем ...
      ######################################################
      @Arr_da=[["26", "Общая оборачиваемость капитала (деловая активность)", "Kobk"],
            ["27", "Оборачиваемость оборотных средств (краткосрочных активов)", "Kobs"],
            ["28", "Оборачиваемость запаса сырья, материалов и полуфабрикатов", "Kobzs"],
            ["29", "Оборачиваемость готовой продукции", "Kobgp"],
            ["30", "Оборачиваемость дебиторской задолженности", "Kobdz"],
            ["31", "Оборачиваемость кредиторской задолженности", "Kobkz"]]
            
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
      # Готовим целевые таблицы - чистим за период по предприятию определённый тип диаграмм "с 32 по 38"... 
      # (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).Diagram(32,38).destroy_all
      # ... и заполняем ...
      ######################################################
      @Arr_ren=[["32", "Рентабельность продаж", "Krenprod"],
            ["33", "Рентабельность активов", "Krenact"],
            ["34", "Рентабельность собственного капитала", "Krensk"],
            ["35", "Рентабельность производственных затрат, составляющих себестоимость", "Krenpz"],
            ["36", "Рентабельность полной себестоимости реализованной продукции", "Krenps"],
            ["37", "Рентабельность общих расходов коммерческой организации", "Krenor"],
            ["38", "Рентабельность расходов, обусловивших получение чистой прибыли", "Krenchp"]]
            
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
  
  private
  def get_enterprise
    @enterprise=Enterprise.find_by_id(params[:id])
  end
end