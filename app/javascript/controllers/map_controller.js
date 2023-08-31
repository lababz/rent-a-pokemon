import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl' // Don't forget this!
// Connects to data-controller="map"
export default class extends Controller {
  static values = {
    apiKey: String,
    marker: Array
  }
  connect() {
    mapboxgl.accessToken = this.apiKeyValue
    this.map = new mapboxgl.Map({
      container: this.element,
      style: "mapbox://styles/mapbox/streets-v10"
    })

    // Call private methods
		this.#addMarkerToMap()
		this.#fitMapToMarkers()
  }

  // Private method to display marker
	#addMarkerToMap() {
	  this.markerValue.forEach((marker) => {
      const popup = new mapboxgl.Popup().setHTML(marker.info_window_html)

      // Create a HTML element for your custom marker
      const customMarker = document.createElement("div")
      customMarker.innerHTML = marker.marker_html

      // Pass the element as an argument to the new marker
      new mapboxgl.Marker(customMarker)
        .setLngLat([marker.lng, marker.lat])
        .setPopup(popup)
        .addTo(this.map)
	  })
	}

	// Private method to fit the map scale to the markers
	#fitMapToMarkers() {
	  const bounds = new mapboxgl.LngLatBounds()
	  this.markerValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
	  this.map.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
	}
}