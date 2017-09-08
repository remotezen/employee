class Off < ApplicationRecord
  belongs_to :user
  scope  :currently_off, -> {end_time > Time.zone.now }
  validates :start_time, presence:true
  validates :end_time, presence:true

end
