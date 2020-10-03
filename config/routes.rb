Rails.application.routes.draw do
  post 'payments/payday'
  resources :employees do
    resources :timecards
    resources :sales_receipts
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
