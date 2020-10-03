Rails.application.routes.draw do
  resources :sales_receipts
  post 'payments/payday'
  resources :employees do
    resources :timecards
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
