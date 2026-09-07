class LedgerEntry < ApplicationRecord
  belongs_to :wallet

  validates :amount, numericality: {other_than: 0}
  validates :entry_type, inclusion: {in: %w[credit debit]}
end