class Reserva < ApplicationRecord
  belongs_to :vaga

  validates :entrada, presence: true
end
