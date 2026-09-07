module Api
  module V1
    class TransfersController < ApplicationController
      # GET /api/v1/transfers
      def index
        ledger_entries = LedgerEntry.order(created_at: :desc)
        render json: { status: "success", data: ledger_entries }, status: :ok
      end

      # POST /api/v1/transfers
      def create
        sender_wallet = Wallet.find_by(id: params[:sender_wallet_id])
        receiver_wallet = Wallet.find_by(id: params[:receiver_wallet_id])

        if sender_wallet.nil? || receiver_wallet.nil?
          return render json: { status: "error", message: "Wallet tidak ditemukan" }, status: :not_found
        end

        result = TransferService.new(
          sender_wallet: sender_wallet,
          receiver_wallet: receiver_wallet,
          amount: params[:amount].to_f,
          reference_id: params[:reference_id] || "TRX-#{Time.now.to_i}"
        ).call

        if result[:success]
          render json: {
            status: "success",
            message: "Transfer berhasil dilakukan",
            data: {
              sender_balance_now: sender_wallet.reload.balance,
              receiver_balance_now: receiver_wallet.reload.balance
            }
          }, status: :ok
        else
          render json: { status: "error", message: result[:error] }, status: :unprocessable_entity
        end
      end
    end
  end
end