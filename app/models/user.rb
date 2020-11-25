class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable

  has_one_attached :photo
  has_many :tasks
  has_many :attendances
  has_many :meetings, through: :attendances
  has_many :meetings
  has_many :attendances_as_owner, through: :meetings, source: :attendances

  # Google OAuth2 stuff below

  # devise :omniauthable, omniauth_providers: [:google_oauth2]
  # def self.from_omniauth(access_token)
  #   data = access_token.info
  #   user = User.where(email: data['email']).first

  #   # Uncomment the section below if you want users to be created if they don't exist
  #   unless user
  #     user = User.create(name: data['name'],
  #                        email: data['email'],
  #                        password: Devise.friendly_token[0,20]
  #                        )
  #   end
  #   user
  # end

  # def self.find_for_google_oauth2(access_token, signed_in_resource=nil)
  #   data = access_token.info
  #   # if (User.admins.include?(data.email))
  #   #   user = User.find_by(email: data.email)
  #   user = User.find_by(email: data.email)
  #   if user
  #     user.provider = access_token.provider
  #     user.uid = access_token.uid
  #     user.token = access_token.credentials.token
  #     user.save
  #     user
  #   else
  #     redirect_to root
  #   end
  # end
  # end
end
