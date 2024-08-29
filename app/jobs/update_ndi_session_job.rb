# frozen_string_literal: true

class UpdateNdiSessionJob < ApplicationJob
  queue_as :default

  def perform(*args)
    UpdateNdiSessionService.new.run
  end
end
