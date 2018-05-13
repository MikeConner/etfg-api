# == Schema Information
#
# Table name: users
#
#  id                 :bigint(8)        not null, primary key
#  username           :string           default(""), not null
#  encrypted_password :string           default(""), not null
#  sign_in_count      :integer          default(0), not null
#  current_sign_in_at :datetime
#  last_sign_in_at    :datetime
#  current_sign_in_ip :inet
#  last_sign_in_ip    :inet
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#

class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :trackable, :validatable
  
  validates :username, :uniqueness => { :case_sensitive => false }, :presence => true, :allow_blank => false
  
  # Need to turn off email
  def email_required?
    false
  end

  # Need to turn off email
  def email_changed?
    false
  end
  
  # Need to turn off email
  def will_save_change_to_email?
    false
  end
end
