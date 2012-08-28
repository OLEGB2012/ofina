# encoding: utf-8
class ApplicationController < ActionController::Base
  protect_from_forgery
  
  # Проверим, чтобы id-предприятия в Url-параметрах соответствовало текущему авторизованному пользователю. 
  # Если нет, то направлять на список предприятий текущего пользователя...
  prepend_before_filter :enterprise_belongs_to_sing_in_user?, unless: :is_admin? # админу можно всё, т.е. переходить на все предприятия ...)))
  append_before_filter  :reload_rails_admin, if: :rails_admin_path?
    

################################################
  def is_admin? # функция-затычка для фильтра ...
    current_user.try(:admin?)
  end
##########################################################################################
  def reload_rails_admin # Для автоперегрузки сведений по моделям во время девелопмента...
    models = ActiveRecord::Base.models
    models.each do |m|
      RailsAdmin::Config.reset_model(m)
    end
    RailsAdmin::Config::Actions.reset

    load("#{Rails.root}/config/initializers/rails_admin.rb")
  end

  def rails_admin_path?
    controller_path =~ /rails_admin/ && Rails.env == "development"
  end
#########################################################################################################################
  def enterprise_belongs_to_sing_in_user?    # Пользователям не-админам должны ограничить доступ к другим предприятиям ....
    if current_user.nil?
      #      flash[:error] = "Пользователя нет..."
    else
      if params[:controller]=='enterprises' 
        if params[:id].nil? and params[:enterprise_id].nil?
#          flash[:success] = "нет id предприятия в параметрах"
        else
          if not params[:id].nil?
            @id=params[:id]
          end
          if not params[:enterprise_id].nil?
            @id=params[:enterprise_id]
          end
          check_belong(@id)
          #          flash[:success] = "есть id предприятия в параметрах"+" "+check_belong(@id)          
        end
      else 
        # Контроллер другого ресурса ...
        if params[:controller]=='calculations' or params[:controller]=='checkings' or params[:controller]=='results'
          if params[:id].nil?
          #            flash[:success] = "нет id предприятия в параметрах"
          else
            @id=params[:id]            
            check_belong(@id)
            #            flash[:success] = "есть id предприятия в параметрах"+": "+check_belong(@id)
          end
        else # Другой контроллер для вложенных в предприятие ресурсов ...
          if params[:enterprise_id].nil?
            #            flash[:success] = "нет id предприятия в параметрах"
          else
            @id=params[:enterprise_id]            
            check_belong(@id)
            #            flash[:success] = "есть id предприятия в параметрах"+": "+check_belong(@id)
          end
        end  
      end            
    end    
  end
############################################################################################# 
  def check_belong(checked_ent_id)  # работает в связке с enterprise_belongs_to_sing_in_user?
    @enterprise=Enterprise.find_by_id(checked_ent_id.to_i)
    if not @enterprise.nil?
      if @enterprise.user_id==current_user.id
        #      'Предприятие '+checked_ent_id+' принадлежит текущему пользователю '+current_user.username
        #       flash[:notice] = 'Предприятие '+checked_ent_id+' принадлежит текущему пользователю '+current_user.username
      else
        #      "Предприятие с кодом "+checked_ent_id+" не принадлежит текущему пользователю "+current_user.username
        flash[:alert] = "Предприятие с кодом "+checked_ent_id+" не принадлежит текущему пользователю "+current_user.username
        redirect_to enterprises_path        
      end
    else
      #      "В Базе нет Предприятия с кодом "+checked_ent_id+" ..."
        flash[:alert] = "В Базе нет Предприятия с кодом "+checked_ent_id+" ..."
        redirect_to enterprises_path
    end
  end
  
end
