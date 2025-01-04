import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["recipientType", "toggleable"];

    connect() {
        const recipientType = this.recipientTypeTarget;
    }

    toggle() {
        const recipientType = this.recipientTypeTarget.value;
        this.toggleableTargets;

        this.toggleableTargets.map(element => {
            if (element.dataset.id.toLowerCase() == recipientType.toLowerCase()) {
                element.classList.remove('hidden');
            } else {
                element.classList.add('hidden');
            }
        })
    }
}
