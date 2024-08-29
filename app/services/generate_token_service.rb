# frozen_string_literal: true

require 'jwt'

class GenerateTokenService < ApplicationService
  attr_accessor :thread_id

  def run
    JWT.encode({ thread_id: thread_id }, Rails.application.secrets.secret_key_base)
  end
end
