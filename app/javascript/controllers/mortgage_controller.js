import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
  static targets = [ "homePrice", "downPayment", "downPercent", "interestRate", "mortgageTerm"]

  calculate(event) {
    event.preventDefault();

    console.log("Printing before logging")

    console.log(`ComputedAmount: ${this.computedAmount()}`) 
    console.log(`ComputedRate: ${this.computedRate()}`) 
    console.log(`ComputedTerm: ${this.computedTerm()}`) 

    console.log(`getMontlyPayment: ${this.getMontlyPayment()}`) 

    this.alertResults()
  }

  // display helper functions
  alertResults() {
    window.alert(`The calculated Mortgage Montly Payment: $${this.getMontlyPayment()}`);
  }

  // calculator helper functions
  getMontlyPayment() {
    return this.computedAmount() * ( this.computedRate() * Math.pow(this.computedRate() + 1, this.computedTerm())) / ( Math.pow(this.computedRate() + 1, this.computedTerm()) -1 );
  }

  computedAmount() {
    return this.home_price - this.down_payment
  }

  computedRate() {
    return ((this.interest_rate / 100 ) / 12)
  }

  computedTerm() {
    return (this.mortgage_term * 12)
  }

  // input getter functions
  get home_price() {
    return parseInt(this.homePriceTarget.value)
  }

  get down_payment() {
    return parseInt(this.downPaymentTarget.value)
  }

  get down_percent() {
    return parseInt(this.downPercentTarget.value)
  }

  get interest_rate() {
    return parseInt(this.interestRateTarget.value)
  }

  get mortgage_term() {
    return parseInt(this.mortgageTermTarget.value)
  }
} 
