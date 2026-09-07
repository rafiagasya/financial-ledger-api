class CreateWallets < ActiveRecord::Migration[8.1]
  def change
    create_table :wallets do |t|
      t.references :user, null: false, foreign_key: true
      t.decimal :balance, precision: 15, scale: 2
      t.string :currency

      t.timestamps
    end
  end
end
