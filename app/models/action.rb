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

class Action < EtfgDbBase
  belongs_to :action_category
  
  validates_presence_of :description
    
  has_and_belongs_to_many :users
  
  # :full_historical lets an internal user access < 2017 data for testing
  enum description: [:read_industry, :read_analytics, :read_fund_flow, :read_constituents, 
                     :change_permissions, :manage_users, :full_historical,
                     :read_constituents_archive, :read_constituents_snapshot, :legacy, :sftp,
                     :read_esg_core, :read_esg_ratings, :cca_internal, :read_baskets,
                     :read_canada, :read_europe]
  
  def to_s
    self.description.to_s.humanize
  end
  
  def self.verify_region(user, region)
    ok = true
    
    if 'CA' == region and not user.has_permission(:read_canada)
      ok = false
    elsif 'EU' == region and not user.has_permission(:read_europe)
      ok = false
    end
    
    ok
  end
end
