class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :name, presence: true,
  length: { maximum: 50 }
  validates :email, presence: true,
  length: {maximum: 255},
  format: {with: VALID_EMAIL_REGEX},
  uniqueness: { case_sensitive: false }
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

    def downcase_email
      self.email = email.downcase
    end

   def assign_default_role
     add_role(:user) if self.roles.blank?
   end

end
