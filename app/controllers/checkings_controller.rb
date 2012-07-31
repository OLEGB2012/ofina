# encoding: utf-8
class CheckingsController < ApplicationController
  before_filter :authenticate_user!
  
  def index
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])  
  end
end
