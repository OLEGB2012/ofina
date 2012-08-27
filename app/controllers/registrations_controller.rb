# encoding: utf-8
class  RegistrationsController < Devise::RegistrationsController
  # The path used after sign up. You need to overwrite this method
  # in your own RegistrationsController.
  def after_sign_up_path_for(resource)
    create_enterprise_data
    super
  end
end

private
#################################################
  def create_enterprise_data
    ###########################################################
    # Создадим предприятие и зальём на него данные форм отчётов
    new_enterprise = Enterprise.create!(org_name: 'Для обучения ....', 
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
    current_user.enterprises << new_enterprise
    ##############################################################
    # Пропишем 15 дней доступа для только что созданного юзера ...
    
  end