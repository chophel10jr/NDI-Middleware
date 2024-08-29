# frozen_string_literal: true

require 'jwt'

class DecodeTokenService < ApplicationService
  attr_accessor :token

  def run
    decoded = JWT.decode(token, Rails.application.secrets.secret_key_base)
    decoded[0]['thread_id']
  end
end
