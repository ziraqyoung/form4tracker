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

  // M = P [ i(1 + i)^n ] / [ (1 + i)^n – 1]
  // M = monthly mortgage payment
  // P = the principal, or the initial amount you borrowed.
  // i = your monthly interest rate. Your lender likely lists interest rates as an annual figure, so you’ll need to divide by 12, for each month of the year. So, if your rate is 5%, then the monthly rate will look like this: 0.05/12 = 0.004167.
  // n = the number of payments, or the payment period in months. If you take out a 30-year fixed rate mortgage, this means: n = 30 years x 12 months per year, or 360 payments.
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
