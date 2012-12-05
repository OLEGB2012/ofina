# encoding: utf-8
class NsiMinUstCapsController < ApplicationController
  before_filter :authenticate_user!, :get_enterprise
  before_filter :check_activation, except: [:index,:show]

  def index
    @nsi_min_ust_caps=NsiMinUstCap.EnterpriseFor(params[:enterprise_id]).Sorted.paginate(page: params[:page])
    @OrgName=@enterprise.org_name
  end
  
  def show
    @nsi_min_ust_cap=NsiMinUstCap.find(params[:id])    
    @OrgName=@enterprise.org_name
    @DateVvod=@nsi_min_ust_cap.date_vvod
    @Summa=@nsi_min_ust_cap.summa
  end
  
  def new
    @nsi_min_ust_cap=@enterprise.nsi_min_ust_caps.build
    @OrgName=@enterprise.org_name    
  end
  
  def create
    @nsi_min_ust_cap=@enterprise.nsi_min_ust_caps.build(params[:nsi_min_ust_cap])
    if @nsi_min_ust_cap.save
      flash[:notice]="Запись создана."
      redirect_to enterprise_nsi_min_ust_caps_path(@enterprise)
    else
      render('new')
    end
  end
  
  def edit
    @nsi_min_ust_cap=@enterprise.nsi_min_ust_caps.find_by_id(params[:id])
    @OrgName=@enterprise.org_name    
  end

  def update
    @nsi_min_ust_cap=@enterprise.nsi_min_ust_caps.find_by_id(params[:id])
    if @nsi_min_ust_cap.update_attributes(params[:nsi_min_ust_cap])
      flash[:notice]="Запись обновлена."
      redirect_to enterprise_nsi_min_ust_cap_path(@enterprise)
    else  
      render('edit')
    end
  end
  
  def delete
    @nsi_min_ust_cap=NsiMinUstCap.find(params[:id])
  end
    
  def destroy
    @nsi_min_ust_cap=@enterprise.nsi_min_ust_caps.find_by_id(params[:id])
    @nsi_min_ust_cap.destroy
    flash[:notice]="Запись удалёна."
    redirect_to enterprise_nsi_min_ust_caps_path
  end
  
#  # GET /nsi_min_ust_caps
#  # GET /nsi_min_ust_caps.json
#  def index
#    @nsi_min_ust_caps = NsiMinUstCap.all
#
#    respond_to do |format|
#      format.html # index.html.erb
#      format.json { render json: @nsi_min_ust_caps }
#    end
#  end
#
#  # GET /nsi_min_ust_caps/1
#  # GET /nsi_min_ust_caps/1.json
#  def show
#    @nsi_min_ust_cap = NsiMinUstCap.find(params[:id])
#
#    respond_to do |format|
#      format.html # show.html.erb
#      format.json { render json: @nsi_min_ust_cap }
#    end
#  end
#
#  # GET /nsi_min_ust_caps/new
#  # GET /nsi_min_ust_caps/new.json
#  def new
#    @nsi_min_ust_cap = NsiMinUstCap.new
#
#    respond_to do |format|
#      format.html # new.html.erb
#      format.json { render json: @nsi_min_ust_cap }
#    end
#  end
#
#  # GET /nsi_min_ust_caps/1/edit
#  def edit
#    @nsi_min_ust_cap = NsiMinUstCap.find(params[:id])
#  end
#
#  # POST /nsi_min_ust_caps
#  # POST /nsi_min_ust_caps.json
#  def create
#    @nsi_min_ust_cap = NsiMinUstCap.new(params[:nsi_min_ust_cap])
#
#    respond_to do |format|
#      if @nsi_min_ust_cap.save
#        format.html { redirect_to @nsi_min_ust_cap, notice: 'Nsi min ust cap was successfully created.' }
#        format.json { render json: @nsi_min_ust_cap, status: :created, location: @nsi_min_ust_cap }
#      else
#        format.html { render action: "new" }
#        format.json { render json: @nsi_min_ust_cap.errors, status: :unprocessable_entity }
#      end
#    end
#  end
#
#  # PUT /nsi_min_ust_caps/1
#  # PUT /nsi_min_ust_caps/1.json
#  def update
#    @nsi_min_ust_cap = NsiMinUstCap.find(params[:id])
#
#    respond_to do |format|
#      if @nsi_min_ust_cap.update_attributes(params[:nsi_min_ust_cap])
#        format.html { redirect_to @nsi_min_ust_cap, notice: 'Nsi min ust cap was successfully updated.' }
#        format.json { head :no_content }
#      else
#        format.html { render action: "edit" }
#        format.json { render json: @nsi_min_ust_cap.errors, status: :unprocessable_entity }
#      end
#    end
#  end
#
#  # DELETE /nsi_min_ust_caps/1
#  # DELETE /nsi_min_ust_caps/1.json
#  def destroy
#    @nsi_min_ust_cap = NsiMinUstCap.find(params[:id])
#    @nsi_min_ust_cap.destroy
#
#    respond_to do |format|
#      format.html { redirect_to nsi_min_ust_caps_url }
#      format.json { head :no_content }
#    end
#  end
  
  private
  def get_enterprise
    @enterprise=Enterprise.find_by_id(params[:enterprise_id])
  end
end
