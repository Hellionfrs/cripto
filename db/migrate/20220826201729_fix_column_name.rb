class FixColumnName < ActiveRecord::Migration[7.0]
  def change
    change_table :bitcoins do |t| 
      t.rename :hash, :block_hash
    end
  end
end
