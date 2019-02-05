<template>
  <div>
    <img id="weather-logo" src="./Weather.png" alt="weather ico" height="42" width="42">
    <p class="mb-3 border-b pb-4">{{forecast.summary}}</p>
    <br>
    <p class="mb-3 border-b pb-4">Temperature: {{forecast.temperature}}°c</p>
    <br>
    <p class="mb-3 border-b pb-4">Speed: {{forecast.windSpeed}}mph</p>
    <br>
    <p class="mb-3 border-b pb-4">Wind Gust: {{forecast.windGust}}</p>
    <br>
    <p class="mb-3 border-b pb-4">Chance of Rain: {{(forecast.precipProbability*100).toFixed(2)}}%</p>
    <br>
  </div>
</template>
<script>
const axios = require("axios");
import proxy from "../modules/cors-client.js";
export default {
  props: ["refreshSeconds"],
  data() {
    return {
      forecast: {
        summary: "",
        temperature: "",
        windSpeed: "",
        windGust: "",
        precipProbability: ""
      },
      apiUrl: process.env.VUE_APP_WEATHER_URL
    };
  },
  mounted() {
    setInterval(this.refresh, this.refreshSeconds * 1000);
    let summaryCache = localStorage.getItem("Summary");
    if (summaryCache) {
      this.forecast.summary = JSON.parse(summaryCache);
    }
    let temperatureCache = localStorage.getItem("Temperature");
    if (temperatureCache) {
      this.forecast.temperature = JSON.parse(temperatureCache);
    }
    let windSpeedCache = localStorage.getItem("Speed");
    if (windSpeedCache) {
      this.forecast.windSpeed = JSON.parse(windSpeedCache);
    }
    let windGustCache = localStorage.getItem("Gust");
    if (windGustCache) {
      this.forecast.windGust = JSON.parse(windGustCache);
    }
    let precipProbabilityCache = localStorage.getItem("Rain Chance");
    if (precipProbabilityCache) {
      this.forecast.precipProbability = JSON.parse(precipProbabilityCache);
    }
  },
  methods: {
    refresh() {
      proxy
        .get(this.apiUrl)
        .then(response => {
          const weather = response.data.hourly;
          this.updateValues(weather);
        })
        .catch(error => {
          // handle error
          console.log(error);
          this.error = true;
        });
    },
    updateValues(weather) {
      this.forecast.summary = weather.summary;
      this.forecast.temperature = weather.data[0].temperature;
      this.forecast.windSpeed = weather.data[0].windSpeed;
      this.forecast.windGust = weather.data[0].windGust;
      this.forecast.precipProbability = weather.data[0].precipProbability;
      localStorage.setItem("Summary", JSON.stringify(weather.summary));
      localStorage.setItem(
        "Temperature",
        JSON.stringify(weather.data[0].temperature)
      );
      localStorage.setItem("Speed", JSON.stringify(weather.data[0].windSpeed));
      localStorage.setItem("Gust", JSON.stringify(weather.data[0].windGust));
      localStorage.setItem(
        "Rain Chance",
        JSON.stringify(weather.data[0].precipProbability)
      );
    }
  }
};
</script>



