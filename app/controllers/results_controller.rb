# encoding: utf-8
class ResultsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprise=Enterprise.find_by_id(params[:id])
  end
  ###########################################################################
  # Аналитический баланс (таблично)
  def ab_table
    @enterprise=Enterprise.find_by_id(params[:id])
    @AB=AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("id")
  end
  ###########################################################################
  # Показатели финансовой устойчивости (таблично)
  def fu_table
    @enterprise=Enterprise.find_by_id(params[:id])
    @FU=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
    @FU_MIN_Kfzav =@FU.minimum(:Kfzav)
    @FU_MAX_Kdfnez=@FU.maximum(:Kdfnez)
  end
  ###########################################################################
  # Показатели ликвидности и платёжеспособности (таблично)
  def lp_table
    @enterprise=Enterprise.find_by_id(params[:id])
    @LP=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")  
  end
  ###########################################################################
  # Показатели деловой активности (таблично)
  def da_table
    @enterprise=Enterprise.find_by_id(params[:id])
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
   @enterprise=Enterprise.find_by_id(params[:id])
   @REN=FormTwoReport.FormTwoEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period_end")
   @REN_MAX_Krenprod=@REN.maximum(:Krenprod)
   @REN_MAX_Krenact =@REN.maximum(:Krenact)
   @REN_MAX_Krensk  =@REN.maximum(:Krensk)
   @REN_MAX_Krenpz  =@REN.maximum(:Krenpz)
   @REN_MAX_Krenps  =@REN.maximum(:Krenps)
   @REN_MAX_Krenor  =@REN.maximum(:Krenor)
   @REN_MAX_Krenchp =@REN.maximum(:Krenchp)
  end
  ###########################################################################
  # "аля" Аналитический баланс (графики) из формы 1 баланса.
  def ab_graph      
    @enterprise=Enterprise.find_by_id(params[:id])
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
    @enterprise=Enterprise.find_by_id(params[:id])
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
    @enterprise=Enterprise.find_by_id(params[:id])
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
    @enterprise=Enterprise.find_by_id(params[:id])
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
    @enterprise=Enterprise.find_by_id(params[:id])
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
end