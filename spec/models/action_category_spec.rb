# == Schema Information
#
# Table name: action_categories
#
#  id         :bigint(8)        not null, primary key
#  name       :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

require 'rails_helper'

RSpec.describe ActionCategory, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
