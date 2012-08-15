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
    @AB=AnalyticalBalance.ABEnterpriseFor(params[:id]).WorkPeriod(@enterprise.rab_date_beg,@enterprise.rab_date_end).order("id")
#    @AB_Dyn_Active =@AB.where(["row_type = ? AND G2 <= ?",6,"290"]).all
    @AB_Dyn_Active =@AB.where(["row_type = ?",6]).all
#    @AB_Dyn_Passive=@AB.where(["row_type = ? AND G2 >= ?",6,"410"]).all
  end
end
