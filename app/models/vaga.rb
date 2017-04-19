class Vaga < ApplicationRecord
  has_many :reservas, dependent: :destroy

  validates :descricao, presence: true;

  def reservar_ou_desocupar
    if ocupada
      reservas.last.update(saida: Time.now)
    else
      reservas.create(entrada: Time.now)
    end
    update(ocupada: !ocupada)
  end
end
