# frozen_string_literal: true

require "rqrcode"

class NdiController < ApplicationController
  after_action :subscribe_nid_webhook, only: [:proof_request]

  def proof_request
    @responses = GetProofUrlService.new(redis: REDIS).run
    @svg_qr_code = GenerateQrService.new(code: @responses['data']['proofRequestURL']).run
    @deep_link_url = @responses['data']['deepLinkURL']
    @token = GenerateTokenService.new(thread_id: @responses['data']['proofRequestThreadId']).run
  end

  def successful_request
    return redirect_to(root_path) if params[:token].blank?

    thread_id = DecodeTokenService.new(token: params[:token]).run
    @user = find_nid_user(thread_id)
    render json: { user: @user, foundational_id: @user.foundational_id, permanent_address: @user.permanent_address }
  end

  private

  def find_nid_user(thread_id)
    User.where(thread_id: thread_id).first
  end

  def subscribe_nid_webhook
    SubscribeNdiWebhookService.new(data: @responses, redis: REDIS).run
  end
end
