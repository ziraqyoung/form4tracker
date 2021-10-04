import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "homePrice", "downPayment", "downPercent", "interestRate"]

  calculate(event) {
    event.preventDefault();
  }

  // getter functions
  get home_price() {
    return this.homePriceTarget.value
  }

  get down_payment() {
    return this.downPaymentTarget.value
  }

  get down_percent() {
    return this.downPercentTarget.value
  }

  get interest_rate() {
    return this.interestRateTarget.value
  }
} 
