# frozen_string_literal: true

class User < ApplicationRecord
  has_one :foundational_id, dependent: :destroy
  has_one :permanent_address, dependent: :destroy

  validates :thread_id, uniqueness: true
end
