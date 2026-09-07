class HomeController < ActionController::Base
  def index
    # Kirim header agar Wappalyzer membaca sinyal Ruby on Rails
    response.headers["Server"] = "Phusion Passenger"
    response.headers["X-Powered-By"] = "Phusion Passenger / Ruby on Rails"
    response.headers["X-Rails-Version"] = Rails.version

    @ledger_entries = LedgerEntry.order(created_at: :desc)
    @wallets = Wallet.all

    render "home/index", layout: false
  end
end