class CreateCnabs < ActiveRecord::Migration[6.0]
  def change
    create_table :cnabs do |t|
      t.integer :tipo
      t.date :data
      t.float :valor
      t.string :cpf
      t.string :cartao
      t.string :hora
      t.string :dono
      t.string :loja

      t.timestamps
    end
  end
end
