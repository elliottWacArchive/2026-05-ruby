import { Controller } from "@hotwired/stimulus"

// permet d'ajouter des champs dynamiquement dans un formulaire imbriqué
export default class extends Controller {
  static targets = ["template", "container"]

  addRow(event) {
    event.preventDefault()
    const timestamp = new Date().getTime()
    const html = this.templateTarget.innerHTML.replace(/NEW_RECORD/g, timestamp)
    this.containerTarget.insertAdjacentHTML("beforeend", html)
  }

  removeRow(event) {
    event.preventDefault()
    const row = event.target.closest("[data-nested-form-target='row']")
    const destroyField = row.querySelector("[data-destroy]")
    if (destroyField) {
      destroyField.value = "1"
      row.style.display = "none"
    } else {
      row.remove()
    }
  }
}
