# encoding: utf-8
class StaticPagesController < ApplicationController
  def home
    if user_signed_in?
      @current_year    =Time.now.year
      @enterprises     =Enterprise.UserAreaFor(current_user.id)
      @enterprise_count=@enterprises.count
      @form_one_reports_count=0
      @form_two_reports_count=0
      @form_three_reports_count=0
      @form_four_reports_count=0
      # Пройтись по всем предприятиям данного пользователя, взяв отчёты только по текущему году...
      @enterprises.each do |enterprise|
        @form_one_reports_count  +=enterprise.form_one_reports.where(["date_period>? AND date_period<?",Time.now.beginning_of_year,Time.now.end_of_year]).count
        @form_two_reports_count  +=enterprise.form_two_reports.where(["date_period_beg>? AND date_period_beg<?",Time.now.beginning_of_year,Time.now.end_of_year]).count
        @form_three_reports_count+=enterprise.form_three_reports.where(["date_period_beg>? AND date_period_beg<?",Time.now.beginning_of_year,Time.now.end_of_year]).count
        @form_four_reports_count +=enterprise.form_four_reports.where(["date_period_beg>? AND date_period_beg<?",Time.now.beginning_of_year,Time.now.end_of_year]).count
      end        
    end
  end

  def help
  end
  
  def about
  end
  
  def contact    
  end
  
  def news
  end

end