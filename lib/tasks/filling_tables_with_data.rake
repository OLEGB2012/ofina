# encoding: utf-8
namespace :db do
  desc "Fill database with sample data"
  task populate: :environment do
    make_users
    make_enterprises
    make_form_one_report
    make_form_two_report
    make_form_three_report
    make_form_four_report
  end
end

def make_form_four_report
  FormFourReport.delete_all
  
  new_form4 = FormFourReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31', 
                  S021: 176345, S022: 0, S023: 0, S024: 4756, S031: 82997, S032: 32328, S033: 13178, 
                  S034: 13151, S051: 0, S052: 60, S053: 0, S054: 0, S055: 0,
                  S061: 10488, S062: 42, S063: 0, S064: 0, S081: 27219, S082: 0, S083: 0,
                  S084: 0, S091: 53357, S092: 0, S093: 6186, S094: 0, S095: 0, S120: 7451, S140: 58)
  
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_four_reports << new_form4
  
  new_form4 = FormFourReport.create!(date_period_beg: '2011-01-01', date_period_end: '2011-03-31', 
                  S021: 60799, S022: 0, S023: 0, S024: 498, S031: 21215, S032: 20656, S033: 8372,
                  S034: 2994, S051: 0, S052: 22, S053: 0, S054: 0, S055: 0,
                  S061: 3535, S062: 257, S063: 0, S064: 415, S081: 7666, S082: 0, S083: 0,
                  S084: 0, S091: 14402, S092: 0, S093: 1996, S094: 0, S095: 0, S120: 9934, S140: 103)
  
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_four_reports << new_form4
end

def make_form_three_report
  FormThreeReport.delete_all
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Остаток на '+Russian::strftime(((('2012-01-01').to_date.prev_year-1).end_of_year),"%d %B %Y").to_s+' года',
           G2: '010', G3: 317474, G4: 0, G5: 0, G6: 0, G7: 108359, G8: 18465, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Корректировки в связи с изменением учетной политики',
           G2: '020', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Корректировки в связи с исправлением ошибок',
           G2: '030', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
 
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Cкорректированный остаток на '+Russian::strftime(((('2012-01-01').to_date.prev_year-1).end_of_year),"%d %B %Y").to_s+' года',
           G2: '040', G3: 317474, G4: 0, G5: 0, G6: 0, G7: 108359, G8: 18465, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
 
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'За  период с '+Russian::strftime(('2012-01-01').to_date.prev_year,"%d %B").to_s+
                        ' по '+Russian::strftime(('2012-03-31').to_date.prev_year,"%d %B %Y").to_s+' года',
           G2: '0401', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
 
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Увеличение собственного капитала - всего',
           G2: '050', G3: 0, G4: 0, G5: 0, G6: 0, G7: 1219, G8: 510, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'В том числе:',
           G2: '0501', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'чистая прибыль',
           G2: '051', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 510, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'переоценка долгосрочных активов',
           G2: '052', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'доходы от прочих операций, не включаемые в чистую прибыль (убыток)',
           G2: '053', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'выпуск дополнительных акций',
           G2: '054', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'увеличение номинальной стоимости акций',
           G2: '055', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'вклады собственника имущества (учредителей, участников)',
           G2: '056', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'реорганизация',
           G2: '057', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: '',
           G2: '058', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'прочие',
           G2: '059', G3: 0, G4: 0, G5: 0, G6: 0, G7: 1219, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Уменьшение собственного капитала - всего',
           G2: '060', G3: 0, G4: 0, G5: 0, G6: 0, G7: 305, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'В том числе:',
           G2: '0601', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'убыток',
           G2: '061', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'переоценка долгосрочных активов',
           G2: '062', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'расходы от прочих операций, не включаемые в чистую прибыль (убыток)',
           G2: '063', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'уменьшение номинальной стоимости акций',
           G2: '064', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'выкуп акций (долей в уставном капитале)',
           G2: '065', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'дивиденды и другие доходы от участия в уставном капитале организации',
           G2: '066', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'реорганизаци',
           G2: '067', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: '',
           G2: '068', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'прочие',
           G2: '069', G3: 0, G4: 0, G5: 0, G6: 0, G7: 305, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Изменение уставного капитала',
           G2: '070', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Изменение резервного капитала',
           G2: '080', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Изменение добавочного капитала',
           G2: '090', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Остаток на '+Russian::strftime((('2012-03-31').to_date.prev_year),"%d %B %Y").to_s+' года',
           G2: '100', G3: 317474, G4: 0, G5: 0, G6: 0, G7: 109273, G8: 18975, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Остаток на '+Russian::strftime((('2012-03-31').to_date.prev_year.end_of_year),"%d %B %Y").to_s+' года',
           G2: '110', G3: 404165, G4: 0, G5: 0, G6: 167, G7: 527160, G8: 17908, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3 
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Корректировки в связи с изменением учетной политики',
           G2: '120', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Корректировки в связи с исправлением ошибок',
           G2: '130', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Cкорректированный остаток на '+Russian::strftime((('2012-03-31').to_date.prev_year.end_of_year),"%d %B %Y").to_s+' года',
           G2: '140', G3: 404165, G4: 0, G5: 0, G6: 167, G7: 527160, G8: 17908, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'За  период с '+Russian::strftime(('2012-01-01').to_date,"%d %B").to_s+
                        ' по '+Russian::strftime(('2012-03-31').to_date,"%d %B %Y").to_s+' года',
           G2: '1401', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Увеличение собственного капитала - всего',
           G2: '150', G3: 13501, G4: 0, G5: 0, G6: 231, G7: 84, G8: 0, G9: 5)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
    new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'В том числе:',
           G2: '1501', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'чистая прибыль',
           G2: '151', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 5)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'переоценка долгосрочных активов',
           G2: '152', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3  
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'доходы от прочих операций, не включаемые в чистую прибыль (убыток)',
           G2: '153', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'выпуск дополнительных акций',
           G2: '154', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'увеличение номинальной стоимости акций',
           G2: '155', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'вклады собственника имущества (учредителей, участников)',
           G2: '156', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'реорганизация',
           G2: '157', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: '',
           G2: '158', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'прочие',
           G2: '159', G3: 13501, G4: 0, G5: 0, G6: 231, G7: 84, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3

  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Уменьшение собственного капитала - всего',
           G2: '160', G3: 0, G4: 0, G5: 0, G6: 0, G7: 1805, G8: 532, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'В том числе:',
           G2: '1601', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'убыток',
           G2: '161', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'переоценка долгосрочных активов',
           G2: '162', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'расходы от прочих операций, не включаемые в чистую прибыль (убыток)',
           G2: '163', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: ' уменьшение номинальной стоимости акций',
           G2: '164', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'выкуп акций (долей в уставном капитале)',
           G2: '165', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'дивиденды и другие доходы от участия в уставном капитале организации',
           G2: '166', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 301, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'реорганизация',
           G2: '167', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: '',
           G2: '168', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'прочие',
           G2: '169', G3: 0, G4: 0, G5: 0, G6: 0, G7: 1805, G8: 231, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Изменение уставного капитала',
           G2: '170', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Изменение резервного капитала',
           G2: '180', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Изменение добавочного капитала',
           G2: '190', G3: 0, G4: 0, G5: 0, G6: 0, G7: 0, G8: 0, G9: 0)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
  
 new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
           G1: 'Остаток на '+Russian::strftime((('2012-03-31').to_date),"%d %B %Y").to_s+' года',
           G2: '200', G3: 417666, G4: 0, G5: 0, G6: 398, G7: 525439, G8: 17376, G9: 5)
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3   
end

def make_form_two_report
  FormTwoReport.delete_all
  
  new_form2 = FormTwoReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31', 
                  S010: 229282, S020: 143297, S040: 29166, S050: 2100, 
                  S070: 73187, S080: 74378, S101: 875, S102: 0, S103: 133, S104: 0, 
                  S111: 7, S112: 123, S121: -20, S122: 0, S131: 5863, S132: 47919, S133: 0, 
                  S140: 0, S170: 599, S180: 0, S190: 0, S200: 0, S211: 1, 
                  S212: 5, S213: 0, S214: 0, S220: 0, S230: 0, S250: 0, S260: 0)
  
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_two_reports << new_form2
  
  new_form2 = FormTwoReport.create!(date_period_beg: '2011-01-01', date_period_end: '2011-03-31', 
                  S010: 72146, S020: 67257, S040: 0, S050: 1054, S070: 45042, S080: 37021, 
                  S101: 18, S102: 0, S103: 0, S104: 0, S111: 0, S112: 0,
                  S121: 0, S122: 0, S131: 0, S132: 11175, S133: 0, S140: 0,
                  S170: 393, S180: 0, S190: 0, S200: 0, S211: 1, S212: 508, S213: 0, S214: 0,
                  S220: 0, S230: 0, S250: 0, S260: 0)
  
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_two_reports << new_form2
end

def make_form_one_report
  FormOneReport.delete_all
  
  new_form1 = FormOneReport.create!(date_period: '2012-03-31', 
                                    S110:  816528, S120:   6862, S131:       0, 
                                    S132:       0, S133:      0, S140:  95179, S150:   74013, 
                                    S160:       0, S170:    167, S180:   5155,
                                    S211:  52457, S212:      0, S213:   41052, 
                                    S214:   68076, S215:      0, S216:      0, S220:       0, 
                                    S230:  175778, S240:   4378, S250:  72102, S260:     189, 
                                    S270:    4104, S280:  74371,
                                    S410:  417666, S420:      0, S430:      0, S440:     398, 
                                    S450:  525439, S460:  17376, S470:      5, S480:       0,
                                    S510:  252320, S520:      0, S530:      0, 
                                    S540:       0, S550:      0, S560:      0, 
                                    S610:  184391, S620:      0, S630:  89181, S631:   28078, 
                                    S632:   33065, S633:   4754, S634:   4050, S635:   12908, 
                                    S636:       0, S637:   3611, S638:   2715, S640:       0, 
                                    S650:     855, S660:      0, S670:   2780)
          
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_one_reports << new_form1

  new_form1 = FormOneReport.create!(date_period: '2011-12-31', 
                                    S110:  821034, S120:   6199, S131:        0, 
                                    S132:       0, S133:      0, S140:  94410, S150:    74013, 
                                    S160:       0, S170:    161, S180:   5155,
                                    S211:  44733, S212:      0, S213:    36009, 
                                    S214:   39432, S215:  41239, S216:      0, S220:        0, 
                                    S230:  211394, S240:   5967, S250:  19280, S260:      218, 
                                    S270:    7451, S280:  55822,
                                    S410:  404165, S420:      0, S430:      0, S440:      167, 
                                    S450:  527160, S460:  17908, S470:      0, S480:        0,
                                    S510:  260004, S520:      0, S530:      0, 
                                    S540:       0, S550:      0, S560:      0, 
                                    S610:  163379, S620:      0, S630:  86906, S631:    36210, 
                                    S632:   26046, S633:   3827, S634:   3392, S635:    10117, 
                                    S636:       0, S637:   3283, S638:   4031, S640:        0, 
                                    S650:      48, S660:      0, S670:   2780)
          
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_one_reports << new_form1
#    
#  
#  users = User.all
#  user = users.first
#  followed_users = users[2..50]
#  followers = users[3..40]
#  followed_users.each { |followed| user.follow!(followed) }
#  followers.each { |follower| follower.follow!(user) }
end

def make_enterprises
  Enterprise.delete_all
  
  new_enterprise = Enterprise.create!(org_name: 'ЁКЛМЭНЭ-холдинг', 
                                      uch_nomer_plat: '123456789',
                                      vid_econom_deyatel: 'Многопрофильный ходинг' ,
                                      organiz_pravo_form: 'ОАО',
                                      organ_upravlen: 'Частное предприятие', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Преображенская,40')
  user = User.find_by_id(1)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'БелПласт', 
                                      uch_nomer_plat: '987654321',
                                      vid_econom_deyatel: 'Производство пластмассовых изделий' ,
                                      organiz_pravo_form: 'ОАО',
                                      organ_upravlen: 'Концерн Белнефтехим', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Крылья Советов,13')
  user = User.find_by_id(2)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'New Logistic', 
                                      uch_nomer_plat: '123456789', 
                                      vid_econom_deyatel: 'Логистические услуги, грузоперевозки' ,
                                      organiz_pravo_form: 'ЗАО',
                                      organ_upravlen: 'Частное предприятие', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул.Малые горки, 50')
  user = User.find_by_id(2)
  user.enterprises << new_enterprise
  
  new_enterprise = Enterprise.create!(org_name: 'Электро-техно', 
                                      uch_nomer_plat: '987654321', 
                                      vid_econom_deyatel: 'Производство электронных изделий' ,
                                      organiz_pravo_form: 'Унитарное предприятие',
                                      organ_upravlen: 'Концерн приборостороения', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Космонавтов, 64')
  
  user = User.find_by_id(3)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Красный пищевик', 
                                      uch_nomer_plat: '123456789', 
                                      vid_econom_deyatel: 'Производство кондитерских изделий' ,
                                      organiz_pravo_form: 'ОАО',
                                      organ_upravlen: 'Концерн Белгоспищепром', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Бахарова, 45')
  user = User.find_by_id(4)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Трикотажка', 
                                      uch_nomer_plat: '987654321', 
                                      vid_econom_deyatel: 'Производство трикотажных изделий' ,
                                      organiz_pravo_form: 'ОАО',
                                      organ_upravlen: 'Концерн Беллегпром', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Первомайская, 40')
  user = User.find_by_id(5)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Купи-продайка', 
                                      uch_nomer_plat: '123456789', 
                                      vid_econom_deyatel: 'Оптово-розничная торговля' ,
                                      organiz_pravo_form: 'ЧУП',
                                      organ_upravlen: 'Частное', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Где-то там на пригорке')
  user = User.find_by_id(6)
  user.enterprises << new_enterprise
end

def make_users
  User.delete_all
  admin = User.create(username: "Example User", 
                      email: "example@railstutorial.org", 
                      password: "foobar", 
                      remember_me: false)
  admin.toggle!(:admin)
  5.times do |n|
    username = Faker::Name.name
    email = "example-#{n+1}@railstutorial.org"
    password = "password"
    User.create!(username: username, 
                 email: email, 
                 password: password, 
                 password_confirmation: password, 
                 remember_me: false)
  end
end