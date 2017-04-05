class Vaga < ApplicationRecord
  has_many :reservas

  validates :descricao, presence: true;
end
