# frozen_string_literal: true

class RegisterNdiWebhookService < ApplicationService
  attr_accessor :redis

  def run
    response = send_post_request(url, body, headers)
    JSON.parse(response.body)
  rescue StandardError => e
    Rails.logger.error("Error registering NDI webhook: #{e.message}")
  end

  private

  def url
    URI.parse(ENV['NDI_WEBHOOK_REGISTER_URL'])
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{redis.get('access_token')}"
    }
  end

  def body
    {
      webhookId: "BNBL005",
      webhookURL: "https://dcd6-118-103-138-97.ngrok-free.app/ndi_webhooks",
      authentication: {
        type: "OAuth2",
        version: "v2",
        data: {
          token: "BNBL20240010"
        }
      }
    }
  end
end
