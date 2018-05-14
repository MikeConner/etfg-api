# == Schema Information
#
# Table name: actions
#
#  id                 :bigint(8)        not null, primary key
#  action_category_id :bigint(8)
#  description        :integer          not null
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class Action < ApplicationRecord
  belongs_to :action_category
  
  validates_presence_of :description
    
  has_and_belongs_to_many :users
  
  enum description: [:read_industry, :read_analytics, :read_fund_flow, :read_constituents]
  
  def to_s
    self.description.to_s.humanize
  end
end
