Plutus::Engine.routes.draw do
  root :to => 'reports#balance_sheet'

  get 'reports/balance_sheet' => 'reports#balance_sheet'
  get 'reports/income_statement' => 'reports#income_statement'

  resources :accounts
  resources :entries, only: [:index]
end
