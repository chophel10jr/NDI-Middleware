# frozen_string_literal: true

class SubscribeNdiWebhookService < ApplicationService
  attr_accessor :data, :redis

  def run
    url = URI.parse(ENV['NDI_WEBHOOK_SUBSCRIBING_URL'])
    headers = create_headers
    body = create_body
    response = send_post_request(url, body, headers)
    JSON.parse(response.body)
  rescue StandardError => e
    Rails.logger.error("Error subscribing NDI webhook: #{e.message}")
  end

  private

  def create_headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{redis.get('access_token')}"
    }
  end

  def create_body
    {
      webhookId: "BNBL005",
      threadId: data['proofRequestThreadId']
    }
  end
end
