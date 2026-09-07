class CreateLedgerEntries < ActiveRecord::Migration[8.1]
  def change
    create_table :ledger_entries do |t|
      t.references :wallet, null: false, foreign_key: true
      t.decimal :amount, precision: 15, scale: 2
      t.string :entry_type
      t.string :reference_id
      t.string :description

      t.timestamps
    end
  end
end
