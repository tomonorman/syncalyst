class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :tasks
  has_many :attendances
  has_many :meetings, through: :attendances
  has_many :attendances_as_owner, through: :meetings, source: :attendances
end
