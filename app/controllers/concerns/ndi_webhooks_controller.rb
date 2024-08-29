# frozen_string_literal: true

class NdiWebhooksController < ApplicationController
  before_action :authorize_request, only: [:create]
  skip_before_action :verify_authenticity_token, only: [:create]

  def create
    data = construct_data(params)
    user = User.create(thread_id: data["thread_id"])
    create_foundational_id(user.id, data)
    create_permanent_address(user.id, data)

    render plain: 'Accepted', status: 202
  end

  def check_status
    thread_id = DecodeTokenService.new(token: params[:token]).run
    webhook_processed = User.exists?(thread_id: thread_id)
    render json: { webhook_processed: webhook_processed }
  end

  private

  def authorize_request
  end

  def construct_data(params)
    return {} unless params

    requested_data = params.dig("requested_presentation", "revealed_attrs")
    data = {}
    requested_data.each do |key, value|
      snake_case_key = to_snake_case(key)
      data[snake_case_key] = value.first["value"]
    end
  
    data['thread_id'] = params.dig('thid')
    data
  end

  def to_snake_case(str)
    str.gsub(/\s+/, '_').downcase
  end

  def create_foundational_id(user_id, data)
    FoundationalId.create(
      full_name: data["full_name"],
      gender: data["gender"],
      date_of_birth: Date.strptime(data["date_of_birth"], "%m/%d/%Y"),
      id_type: data["id_type"],
      id_number: data["id_number"],
      citizenship: data["citizenship"],
      blood_type: data["blood_type"],
      user_id: user_id
    )
  end

  def create_permanent_address(user_id, data)
    PermanentAddress.create(
      house_number: data["house_number"],
      thram_number: data["thram_number"],
      village: data["village"],
      gewog: data["gewog"],
      dzongkhag: data["dzongkhag"],
      user_id: user_id
    )
  end
end
