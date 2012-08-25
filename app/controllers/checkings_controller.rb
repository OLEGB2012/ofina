# encoding: utf-8
class CheckingsController < ApplicationController
  before_filter :authenticate_user!, :get_enterprise
  
  def index
    
  end
  
  private 
  # здесь параметры берём из формата ?id=N, а не из пути RESTFull архитектуры resourse/N/action/...
  def get_enterprise
    @enterprise=Enterprise.find_by_id(params[:id])
  end
end
