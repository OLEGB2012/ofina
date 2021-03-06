# encoding: utf-8
class BalanseRow < ActiveRecord::Base
  belongs_to :enterprise
  has_many   :balanse_values, :dependent => :destroy  
  
  attr_accessible :date_period_beg, :date_period_end, :diag_type, :name, :summa, :summa_dec
  
  scope :BalanseRowEnterpriseFor, lambda{|enterprise_id_value|where(:enterprise_id => enterprise_id_value)}
  scope :DiagramType, lambda{|type_value|where(:diag_type => type_value)}
  scope :WorkPeriod,  lambda{|date_period_1, date_period_2|where("date_period_beg >= ? AND date_period_end <= ?", date_period_1, date_period_2)}
  scope :Diagram,     lambda{|diag_type_1, diag_type_2|where("diag_type >= ? AND diag_type <= ?", diag_type_1, diag_type_2)}  
end
