class EnterprisesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprises=Enterprise.where(:user_id => current_user.id).paginate(page: params[:page])    
  end
  
  def delete
    
  end
  
  def edit
    
  end
  
  def new
    
  end
end
