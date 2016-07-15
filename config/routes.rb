Rails.application.routes.draw do
  resource :payment, only: [:new, :create, :show]
  root to: 'payments#new'
end
