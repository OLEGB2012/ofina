class EnterprisesController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprises=Enterprise.UserAreaFor(current_user.id).paginate(page: params[:page])    
  end
  
  def show
    @enterprise=Enterprise.find(params[:id])
  end
  
  def delete
    
  end
  
  def edit
    
  end
  
  def new
    
  end
  
  
  
  def create
    
  end
  
  def update
    
  end
  
  def destroy
    
  end
end
