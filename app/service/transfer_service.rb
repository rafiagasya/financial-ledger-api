class TransferService
  def initialize(sender_wallet:, receiver_wallet:, amount:, reference_id:, description: nil)
    @sender_wallet = sender_wallet
    @receiver_wallet = receiver_wallet
    @amount = amount.to_d
    @reference_id = reference_id
    @description = description
  end

  def call
    return { success: false, error: "Jumlah transfer harus lebih dari 0" } if @amount <= 0
    return { success: false, error: "Mata uang wallet tidak cocok" } if @sender_wallet.currency != @receiver_wallet.currency

    ActiveRecord::Base.transaction do
      # 1. Cek kecukupan saldo pengirim
      raise ActiveRecord::Rollback, "Saldo tidak mencukupi" if @sender_wallet.balance < @amount

      # 2. Kurangi saldo pengirim & catat DEBIT
      @sender_wallet.update!(balance: @sender_wallet.balance - @amount)
      LedgerEntry.create!(
        wallet: @sender_wallet,
        amount: -@amount,
        entry_type: 'debit',
        reference_id: @reference_id,
        description: @description || "Transfer keluar ke wallet ##{@receiver_wallet.id}"
      )

      # 3. Tambah saldo penerima & catat KREDIT
      @receiver_wallet.update!(balance: @receiver_wallet.balance + @amount)
      LedgerEntry.create!(
        wallet: @receiver_wallet,
        amount: @amount,
        entry_type: 'credit',
        reference_id: @reference_id,
        description: @description || "Transfer masuk dari wallet ##{@sender_wallet.id}"
      )

      { success: true }
    end
  rescue ActiveRecord::Rollback => e
    { success: false, error: e.message }
  rescue StandardError => e
    { success: false, error: e.message }
  end
end