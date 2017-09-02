class Event < ApplicationRecord
  attr_reader :errors
#n = (e.start_time + 24.hours).to_datetime
#n = ((e.end_time - e.start_time)/24.hour).round
  validates :name, presence:true, length:{maximum: 20},
    uniqueness: {case_sensitive: false} 
  validates :job, presence:true
  validates :start_time, presence:true
  validates :end_time, presence:true

 
  belongs_to :user
  #rolify
  resourcify

  scope :reversed, -> { order 'start_time ASC' }
  scope :desc, -> {order 'end_time DESC'}
  scope :top, -> { order 'start_time ASC' }
  scope :shift, -> { where 'end_time < Time.zone.now' }
  default_scope {order('end_time DESC')}

  
  
end
