import { Controller } from "stimulus";

export default class extends Controller {
  static values = { token: String };

  connect() {
    this.pollingTimeout = null;
    this.startPolling();
  }

  startPolling() {
    setTimeout(this.checkWebhookProcessed.bind(this), 10000);
  }

  checkWebhookProcessed() {
    const params = new URLSearchParams({ token: this.tokenValue }).toString();
    fetch(`/check_webhook_status?${params}`)
      .then(response => response.json())
      .then(data => {
        if (data.webhook_processed) {
          window.location.href = `/success-request?${params}`;
        } else {
          this.pollingTimeout = setTimeout(this.checkWebhookProcessed.bind(this), 5000);
        }
      });
  }
}
