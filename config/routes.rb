Rails.application.routes.draw do
  root to: 'ndi#proof_request'

  post '/ndi_webhooks', to: 'ndi_webhooks#create'
  get 'check_webhook_status', to: 'ndi_webhooks#check_status'
  get 'proof-request', to: 'ndi#proof_request'
  get 'success-request', to: 'ndi#successful_request'
end