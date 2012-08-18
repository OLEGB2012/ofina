# encoding: utf-8
class BalanseValue < ActiveRecord::Base
  belongs_to :balanse_row
    
  attr_accessible :date_period, :summa
  
  def rus_date_period
    Russian::strftime(self[:date_period],"%d %B %Y г.")
  end
  
end
