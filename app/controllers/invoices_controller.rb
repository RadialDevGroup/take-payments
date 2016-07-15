class InvoicesController < ApplicationController
  http_basic_authenticate_with name: ENV['username'], password: ENV['password']

  def new
    @invoice = Invoice.new
  end

  def create
    @param = ::Base64.encode64(params.require(:invoice).to_json)
  end
end
