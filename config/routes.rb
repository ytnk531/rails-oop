Rails.application.routes.draw do
  resources :paydays
  post 'payments/payday'
  resources :employees do
    resources :timecards
    resources :sales_receipts
  end
  resources :service_charges
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
