# frozen_string_literal: true

class GetProofUrlService < ApplicationService
  attr_accessor :redis

  def run
    response = send_post_request(url, body, headers)
    JSON.parse(response.body)
  rescue StandardError => e
    Rails.logger.error("Error: #{e.message}")
  end

  private

  def url
    URI.parse(ENV['NDI_PROOF_REQUEST_URL'])
  end

  def headers
    {
      'Content-Type' => 'application/json',
      'Authorization' => "Bearer #{redis.get('access_token')}"
    }
  end

  def body
    {
      proofName: 'Verify Foundational ID',
      proofAttributes: proof_attributes
    }
  end

  def proof_attributes
    attributes = [
      "Full Name",
      "Gender",
      "Date of Birth",
      "ID Type",
      "ID Number",
      "Citizenship",
      "Blood Type",
      "House Number",
      "Thram Number",
      "Village",
      "Gewog",
      "Dzongkhag"
    ]
    attributes.map do |attribute|
      {
        name: attribute,
        restrictions: [
          {
            schema_name: schema_name(attribute)
          }
        ]
      }
    end
  end

  def schema_name(attribute)
    case attribute
    when "House Number", "Thram Number", "Village", "Gewog", "Dzongkhag"
      "https://dev-schema.ngotag.com/schemas/8e87108e-d446-4681-b4a5-7b0952951ea4"
    else
      "https://dev-schema.ngotag.com/schemas/c7952a0a-e9b5-4a4b-a714-1e5d0a1ae076"
    end
  end  
end
