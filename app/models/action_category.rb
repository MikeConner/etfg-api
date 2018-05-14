# == Schema Information
#
# Table name: action_categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ActionCategory < ApplicationRecord
  validates_presence_of :name
  
  has_many :actions
end
