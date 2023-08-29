import { Controller } from "@hotwired/stimulus";

export default class extends Controller {
  static targets = ["startDate", "endDate", "totalPrice"];

  updateTotalPrice() {
    const pricePerDayElement = document.getElementById("pricePerDay");
    const pricePerDay = parseFloat(pricePerDayElement.textContent);
    const startDate = new Date(this.startDateTarget.value);
    const endDate = new Date(this.endDateTarget.value);
    const totalPrice = (endDate - startDate) / (1000 * 60 * 60 * 24) * pricePerDay;

    this.totalPriceTarget.textContent = totalPrice.toFixed(2) + "€";
  }
}
