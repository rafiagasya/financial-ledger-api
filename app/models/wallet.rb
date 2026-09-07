class Wallet < ApplicationRecord
  belongs_to :user
  has_many :ledger_entries, dependent: :destroy

  validates :balance, numericality: { greater_than_or_equal_to: 0 }
  validates :currency, presence: true
end