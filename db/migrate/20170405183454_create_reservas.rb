class CreateReservas < ActiveRecord::Migration[5.0]
  def change
    create_table :reservas do |t|
      t.datetime :entrada
      t.datetime :saida
      t.references :vaga, foreign_key: true

      t.timestamps
    end
  end
end
