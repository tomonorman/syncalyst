class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, :omniauth_providers => [:google_oauth2]

  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :tasks
  has_many :attendances
  has_many :meetings, through: :attendances
  has_many :meetings
  has_many :attendances_as_owner, through: :meetings, source: :attendances

  def self.from_omniauth(access_token)
    data = access_token.info
    user = User.where(:email => data["email"]).first

    unless user
      password = Devise.friendly_token[0,20]
      user = User.create(name: data["name"], email: data["email"],
                         password: password, password_confirmation: password
                         )
    end
    user
  end

  def expired?
    expires_at.to_i < Time.current.to_i
  end

end
