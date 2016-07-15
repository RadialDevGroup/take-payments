Rails.application.routes.draw do
  resource :invoices, only: [:new, :create]
  resource :payment, only: [:new, :create, :show]
  root to: 'payments#new'
end
