class Agenda < ApplicationRecord
  belongs_to :meeting
  has_one_attached :audio
end
