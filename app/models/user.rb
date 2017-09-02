class User < ApplicationRecord
  has_many :events
  has_many :offs
  rolify
  after_create :assign_default_role
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable


   scope :normal_user, -> {where(status: 'normal')}
   scope :off_user, -> {where(status: 'off')}
   scope :ill_user, -> {where(status: 'sick')}
   scope :desc, -> {order 'events.end_time DESC'}
  
   
   
   private

   def assign_default_role
     add_role(:user) if self.roles.blank?
   end

end
