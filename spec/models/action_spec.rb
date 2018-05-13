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

require 'rails_helper'

RSpec.describe Action, type: :model do
  pending "add some examples to (or delete) #{__FILE__}"
end
