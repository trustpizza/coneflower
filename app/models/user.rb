class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  after_create :build_default_profile

  has_many :reviews, dependent: :destroy

  has_one :profile, dependent: :destroy
  accepts_nested_attributes_for :profile

  enum :role, { user: 0, moderator: 1, admin: 2, owner: 3 }

  scope :banned, -> { where(banned: true) }

  # Override Devise's active_for_authentication? method
  def active_for_authentication?
    super && !banned?
  end

  # Provide a reason for the user being inactive
  def inactive_message
    !banned? ? super : :banned
  end


  private

  def build_default_profile
    create_profile # This will use factory defaults from Profile
  end
end
  