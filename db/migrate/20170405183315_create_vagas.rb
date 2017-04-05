class CreateVagas < ActiveRecord::Migration[5.0]
  def change
    create_table :vagas do |t|
      t.string :descricao
      t.boolean :ocupada, default: false

      t.timestamps
    end
  end
end
