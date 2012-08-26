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
  FormFourReport.destroy_all
  
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
  FormThreeReport.destroy_all

  # '110' => 'Остаток на '+Russian::strftime((('2012-03-31').to_date.prev_year.end_of_year),"%d %B %Y").to_s+' года'
  # '140' => 'Cкорректированный остаток на '+Russian::strftime((('2012-03-31').to_date.prev_year.end_of_year),"%d %B %Y").to_s+' года' 
  # '1401'=> 'За  период с '+Russian::strftime(('2012-01-01').to_date,"%d %B").to_s+' по '+Russian::strftime(('2012-03-31').to_date,"%d %B %Y").to_s+' года'
  # '200' => 'Остаток на '+Russian::strftime((('2012-03-31').to_date),"%d %B %Y").to_s+' года'
  
  new_form3 = FormThreeReport.create!(date_period_beg: '2012-01-01', date_period_end: '2012-03-31',
              G3_S010: 317474, G4_S010: 0, G5_S010: 0, G6_S010:   0, G7_S010: 108359, G8_S010: 18465, G9_S010: 0,
              G3_S020:      0, G4_S020: 0, G5_S020: 0, G6_S020:   0, G7_S020:      0, G8_S020:     0, G9_S020: 0,
              G3_S030:      0, G4_S030: 0, G5_S030: 0, G6_S030:   0, G7_S030:      0, G8_S030:     0, G9_S030: 0,
              G3_S051:      0, G4_S051: 0, G5_S051: 0, G6_S051:   0, G7_S051:      0, G8_S051:   510, G9_S051: 0,
              G3_S052:      0, G4_S052: 0, G5_S052: 0, G6_S052:   0, G7_S052:      0, G8_S052:     0, G9_S052: 0,
              G3_S053:      0, G4_S053: 0, G5_S053: 0, G6_S053:   0, G7_S053:      0, G8_S053:     0, G9_S053: 0,
              G3_S054:      0, G4_S054: 0, G5_S054: 0, G6_S054:   0, G7_S054:      0, G8_S054:     0, G9_S054: 0,
              G3_S055:      0, G4_S055: 0, G5_S055: 0, G6_S055:   0, G7_S055:      0, G8_S055:     0, G9_S055: 0,
              G3_S056:      0, G4_S056: 0, G5_S056: 0, G6_S056:   0, G7_S056:      0, G8_S056:     0, G9_S056: 0,
              G3_S057:      0, G4_S057: 0, G5_S057: 0, G6_S057:   0, G7_S057:      0, G8_S057:     0, G9_S057: 0,
              G3_S058:      0, G4_S058: 0, G5_S058: 0, G6_S058:   0, G7_S058:      0, G8_S058:     0, G9_S058: 0,
              G3_S059:      0, G4_S059: 0, G5_S059: 0, G6_S059:   0, G7_S059:   1219, G8_S059:     0, G9_S059: 0,
              G3_S061:      0, G4_S061: 0, G5_S061: 0, G6_S061:   0, G7_S061:      0, G8_S061:     0, G9_S061: 0,
              G3_S062:      0, G4_S062: 0, G5_S062: 0, G6_S062:   0, G7_S062:      0, G8_S062:     0, G9_S062: 0,
              G3_S063:      0, G4_S063: 0, G5_S063: 0, G6_S063:   0, G7_S063:      0, G8_S063:     0, G9_S063: 0,
              G3_S064:      0, G4_S064: 0, G5_S064: 0, G6_S064:   0, G7_S064:      0, G8_S064:     0, G9_S064: 0,
              G3_S065:      0, G4_S065: 0, G5_S065: 0, G6_S065:   0, G7_S065:      0, G8_S065:     0, G9_S065: 0,
              G3_S066:      0, G4_S066: 0, G5_S066: 0, G6_S066:   0, G7_S066:      0, G8_S066:     0, G9_S066: 0,
              G3_S067:      0, G4_S067: 0, G5_S067: 0, G6_S067:   0, G7_S067:      0, G8_S067:     0, G9_S067: 0,
              G3_S068:      0, G4_S068: 0, G5_S068: 0, G6_S068:   0, G7_S068:      0, G8_S068:     0, G9_S068: 0,
              G3_S069:      0, G4_S069: 0, G5_S069: 0, G6_S069:   0, G7_S069:    305, G8_S069:     0, G9_S069: 0,
              G3_S070:      0, G4_S070: 0, G5_S070: 0, G6_S070:   0, G7_S070:      0, G8_S070:     0, G9_S070: 0,
              G3_S080:      0, G4_S080: 0, G5_S080: 0, G6_S080:   0, G7_S080:      0, G8_S080:     0, G9_S080: 0,
              G3_S090:      0, G4_S090: 0, G5_S090: 0, G6_S090:   0, G7_S090:      0, G8_S090:     0, G9_S090: 0,
              G3_S110: 404165, G4_S110: 0, G5_S110: 0, G6_S110: 167, G7_S110: 527160, G8_S110: 17908, G9_S110: 0,
              G3_S120:      0, G4_S120: 0, G5_S120: 0, G6_S120:   0, G7_S120:      0, G8_S120:     0, G9_S120: 0,
              G3_S130:      0, G4_S130: 0, G5_S130: 0, G6_S130:   0, G7_S130:      0, G8_S130:     0, G9_S130: 0,
              G3_S151:      0, G4_S151: 0, G5_S151: 0, G6_S151:   0, G7_S151:      0, G8_S151:     0, G9_S151: 5,
              G3_S152:      0, G4_S152: 0, G5_S152: 0, G6_S152:   0, G7_S152:      0, G8_S152:     0, G9_S152: 0,
              G3_S153:      0, G4_S153: 0, G5_S153: 0, G6_S153:   0, G7_S153:      0, G8_S153:     0, G9_S153: 0,
              G3_S154:      0, G4_S154: 0, G5_S154: 0, G6_S154:   0, G7_S154:      0, G8_S154:     0, G9_S154: 0,
              G3_S155:      0, G4_S155: 0, G5_S155: 0, G6_S155:   0, G7_S155:      0, G8_S155:     0, G9_S155: 0,
              G3_S156:      0, G4_S156: 0, G5_S156: 0, G6_S156:   0, G7_S156:      0, G8_S156:     0, G9_S156: 0,
              G3_S157:      0, G4_S157: 0, G5_S157: 0, G6_S157:   0, G7_S157:      0, G8_S157:     0, G9_S157: 0,
              G3_S158:      0, G4_S158: 0, G5_S158: 0, G6_S158:   0, G7_S158:      0, G8_S158:     0, G9_S158: 0,
              G3_S159:  13501, G4_S159: 0, G5_S159: 0, G6_S159: 231, G7_S159:     84, G8_S159:     0, G9_S159: 0,
              G3_S161:      0, G4_S161: 0, G5_S161: 0, G6_S161:   0, G7_S161:      0, G8_S161:     0, G9_S161: 0,
              G3_S162:      0, G4_S162: 0, G5_S162: 0, G6_S162:   0, G7_S162:      0, G8_S162:     0, G9_S162: 0,
              G3_S163:      0, G4_S163: 0, G5_S163: 0, G6_S163:   0, G7_S163:      0, G8_S163:     0, G9_S163: 0,
              G3_S164:      0, G4_S164: 0, G5_S164: 0, G6_S164:   0, G7_S164:      0, G8_S164:     0, G9_S164: 0,
              G3_S165:      0, G4_S165: 0, G5_S165: 0, G6_S165:   0, G7_S165:      0, G8_S165:     0, G9_S165: 0,
              G3_S166:      0, G4_S166: 0, G5_S166: 0, G6_S166:   0, G7_S166:      0, G8_S166:   301, G9_S166: 0,
              G3_S167:      0, G4_S167: 0, G5_S167: 0, G6_S167:   0, G7_S167:      0, G8_S167:     0, G9_S167: 0,
              G3_S168:      0, G4_S168: 0, G5_S168: 0, G6_S168:   0, G7_S168:      0, G8_S168:     0, G9_S168: 0,
              G3_S169:      0, G4_S169: 0, G5_S169: 0, G6_S169:   0, G7_S169:   1805, G8_S169:   231, G9_S169: 0,
              G3_S170:      0, G4_S170: 0, G5_S170: 0, G6_S170:   0, G7_S170:      0, G8_S170:     0, G9_S170: 0,
              G3_S180:      0, G4_S180: 0, G5_S180: 0, G6_S180:   0, G7_S180:      0, G8_S180:     0, G9_S180: 0,
              G3_S190:      0, G4_S190: 0, G5_S190: 0, G6_S190:   0, G7_S190:      0, G8_S190:     0, G9_S190: 0)
          
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_three_reports << new_form3
end

def make_form_two_report
  FormTwoReport.destroy_all
  
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
                  S121: 202, S122: 0, S131: 0, S132: 11175, S133: 0, S140: 0,
                  S170: 393, S180: 0, S190: 0, S200: 0, S211: 1, S212: 508, S213: 0, S214: 0,
                  S220: 0, S230: 0, S250: 0, S260: 0)
  
  enterprise = Enterprise.find_by_id(4)
  enterprise.form_two_reports << new_form2
end

def make_form_one_report
  FormOneReport.destroy_all
  
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
                                    S610:  184391, S620:      0, S631:   28078, 
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
                                    S610:  163379, S620:      0, S631:    36210, 
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
  Enterprise.destroy_all
  
  new_enterprise = Enterprise.create!(org_name: 'ЁКЛМЭНЭ-холдинг', 
                                      uch_nomer_plat: '123456789',
                                      vid_econom_deyatel: 'Многопрофильный ходинг' ,
                                      organiz_pravo_form: 'ОАО',
                                      organ_upravlen: 'Частное предприятие', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Преображенская,40',
                                      K1: 1.5,
                                      K2: 0.2,
                                      K3: 0.85,
                                      rab_date_beg: '2011-12-31',
                                      rab_date_end: '2012-12-31')
  user = User.find_by_id(1)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'БелПласт', 
                                      uch_nomer_plat: '987654321',
                                      vid_econom_deyatel: 'Производство пластмассовых изделий' ,
                                      organiz_pravo_form: 'ОАО',
                                      organ_upravlen: 'Концерн Белнефтехим', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Крылья Советов,13',
                                      K1: 1.5,
                                      K2: 0.2,
                                      K3: 0.85,
                                      rab_date_beg: '2011-12-31',
                                      rab_date_end: '2012-12-31')
  user = User.find_by_id(2)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'New Logistic', 
                                      uch_nomer_plat: '123456789', 
                                      vid_econom_deyatel: 'Логистические услуги, грузоперевозки' ,
                                      organiz_pravo_form: 'ЗАО',
                                      organ_upravlen: 'Частное предприятие', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул.Малые горки, 50',
                                      K1: 1.15,
                                      K2: 0.15,
                                      K3: 0.85,
                                      rab_date_beg: '2011-12-31',
                                      rab_date_end: '2012-12-31')
  user = User.find_by_id(2)
  user.enterprises << new_enterprise
  
  new_enterprise = Enterprise.create!(org_name: 'Электро-техно', 
                                      uch_nomer_plat: '987654321', 
                                      vid_econom_deyatel: 'Производство электронных изделий' ,
                                      organiz_pravo_form: 'Унитарное предприятие',
                                      organ_upravlen: 'Концерн приборостороения', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Космонавтов, 64',
                                      K1: 1.5,
                                      K2: 0.2,
                                      K3: 0.85,
                                      rab_date_beg: '2011-12-31',
                                      rab_date_end: '2012-03-31')
  
  user = User.find_by_id(3)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Красный пищевик', 
                                      uch_nomer_plat: '123456789', 
                                      vid_econom_deyatel: 'Производство кондитерских изделий' ,
                                      organiz_pravo_form: 'ОАО',
                                      organ_upravlen: 'Концерн Белгоспищепром', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Бахарова, 45',
                                      K1: 1.5,
                                      K2: 0.2,
                                      K3: 0.85,
                                      rab_date_beg: '2011-12-31',
                                      rab_date_end: '2012-12-31')
  user = User.find_by_id(4)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Трикотажка', 
                                      uch_nomer_plat: '987654321', 
                                      vid_econom_deyatel: 'Производство трикотажных изделий' ,
                                      organiz_pravo_form: 'ОАО',
                                      organ_upravlen: 'Концерн Беллегпром', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Первомайская, 40',
                                      K1: 1.5,
                                      K2: 0.2,
                                      K3: 0.85,
                                      rab_date_beg: '2011-12-31',
                                      rab_date_end: '2012-12-31')
  user = User.find_by_id(5)
  user.enterprises << new_enterprise

  new_enterprise = Enterprise.create!(org_name: 'Купи-продайка', 
                                      uch_nomer_plat: '123456789', 
                                      vid_econom_deyatel: 'Оптово-розничная торговля' ,
                                      organiz_pravo_form: 'ЧУП',
                                      organ_upravlen: 'Частное', 
                                      edinic_izmer: 'млн. рубл.',
                                      adres: 'ул. Где-то там на пригорке',
                                      K1: 1.0,
                                      K2: 0.1,
                                      K3: 0.85,
                                      rab_date_beg: '2011-12-31',
                                      rab_date_end: '2012-12-31')
  user = User.find_by_id(6)
  user.enterprises << new_enterprise
end

def make_users
  User.destroy_all
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