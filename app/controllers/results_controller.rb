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
    
  end
end
