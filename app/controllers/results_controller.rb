# encoding: utf-8
class ResultsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprise=Enterprise.find_by_id(params[:id])
  end
  
  def ab_table
    @enterprise=Enterprise.find_by_id(params[:id])
    @AB=AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("id")
  end
  
  def ab_graph      
    @enterprise=Enterprise.find_by_id(params[:id])
    @form_one_reports=FormOneReport.FormOneEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("date_period")
    #######################################################################################
    # 1 - сформируем массив для рисования линейчатых диаграмм по динамике статей баланса (в абсолютных значениях)...
    # Делаем, если есть отчёты-балансы по Форме 1 за период ...
    unless @form_one_reports.empty?
      # Готовим целевые таблицы - чистим ... (записи из balanse_values "уйдут" по каскаду)...
      BalanseRow.BalanseRowEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).destroy_all
      # ... и заполняем ...
      # ################################################################
      @Arr=[["1", "Раздел I. ДОЛГОСРОЧНЫЕ АКТИВЫ", "S190"],
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
            ["4", "Налог на добавл. стоим. по приобр.ТРУ", "S240"],
            ["4", "Краткосрочная дебиторская задол-сть", "S250"],
            ["4", "Краткосрочные финансовые вложения", "S260"],
            ["4", "Денежные средства и их эквиваленты", "S270"],
            ["4", "Прочие краткосрочные активы", "S280"],
            ["5", "Уставный капитал", "S410"],
            ["5", "Неоплаченная часть уставного кап-ла", "S420"],
            ["5", "Собственные акции (доли в уст. кап.)", "S430"],
            ["5", "Резервный капитал", "S440"],
            ["5", "Добавочный капитал", "S450"],
            ["5", "Нераспределенная прибыль (непокр.убыт.)", "S460"],
            ["5", "Чистая прибыль(убыток) отчетного года", "S470"],
            ["5", "Целевое финансирование", "S480"]]
            
      @Arr.each do |x|       
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
  end
end