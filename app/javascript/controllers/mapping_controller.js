import { Controller } from "@hotwired/stimulus"
import mapboxgl from 'mapbox-gl'

// Connects to data-controller="map"
export default class extends Controller {
	static values = {
    apiKey: String,
    markers: Array
  }

  connect() {
    // Authentify with API Key
      mapboxgl.accessToken = this.apiKeyValue

      // Launch Mapbox and display map on the div
      this.mapping = new mapboxgl.Map({
        container: this.element,
        style: "mapbox://styles/mapbox/streets-v10"
      })

    // Call private methods
    this.#addMarkersToMap()
    this.#fitMapToMarkers()
  }

  // Private method to display marker
  #addMarkersToMap() {
    this.markersValue.forEach((marker) => {
      new mapboxgl.Marker()
        .setLngLat([ marker.lng, marker.lat ])
        .addTo(this.map)
    })
  }

  // Private method to fit the map scale to the markers
  #fitMapToMarkers() {
    const bounds = new mapboxgl.LngLatBounds()
    this.markersValue.forEach(marker => bounds.extend([ marker.lng, marker.lat ]))
    this.mapping.fitBounds(bounds, { padding: 70, maxZoom: 15, duration: 0 })
  }
}
