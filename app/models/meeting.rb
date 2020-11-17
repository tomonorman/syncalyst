class Meeting < ApplicationRecord
  belongs_to :user
  has_many :tasks
  has_many :agendas
  has_many :attendances
end
