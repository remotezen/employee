class Off < ApplicationRecord
  belongs_to :user
  scope  :currently_off, -> {end_time > Time.zone.now }

end
