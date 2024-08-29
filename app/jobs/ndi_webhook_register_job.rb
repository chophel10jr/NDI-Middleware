# frozen_string_literal: true

class NdiWebhookRegisterJob < ApplicationJob
  queue_as :default

  def perform(*args)
    record = NdiWebhookRecord.first_or_create

    unless record.executed
      RegisterNdiWebhookService.new(redis: REDIS).run
      puts "Running startup task..."

      # Mark the task as executed
      record.update(executed: true)
    end
  end
end
