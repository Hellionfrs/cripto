class CreateBitcoins < ActiveRecord::Migration[7.0]
  def change
    create_table :bitcoins do |t|
      t.text :block
      t.jsonb :hash

      t.timestamps
    end
  end
end
