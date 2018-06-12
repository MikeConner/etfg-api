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
  
  # :full_historical lets an internal user access < 2017 data for testing
  enum description: [:read_industry, :read_analytics, :read_fund_flow, :read_constituents, :change_permissions, :manage_users, :full_historical]
  
  def to_s
    self.description.to_s.humanize
  end
end
