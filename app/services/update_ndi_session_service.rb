# frozen_string_literal: true

class UpdateNdiSessionService < ApplicationService
  def run
    url = URI.parse(ENV['NDI_SESSION_URL'])
    headers = create_headers
    body = create_body
    responses = send_post_request(url, body, headers)
    update_token(JSON.parse(responses.body)['access_token'])
  rescue StandardError => e
    Rails.logger.error("Error updating NDI session: #{e.message}")
  end

  private

  def create_headers
    {
      'Content-Type' => 'application/json'
    }
  end

  def create_body
    {
      client_id: ENV['NDI_SESSION_CLIENT_ID'],
      client_secret: ENV['NDI_SESSION_CLIENT_SECRET'],
      grant_type: ENV['NDI_SESSION_GRANT_TYPE']
    }
  end

  def update_token(token)
    REDIS.set('access_token', token, ex: 24.hours.to_i)
  end
end
