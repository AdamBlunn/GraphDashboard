<template>
  <div>
    {{forecast.summary}}
    <br>
    Temperature: {{forecast.temperature}}°c
    <br>
    Wind Speed: {{forecast.windSpeed}}mph
    <br>
    Wind Gust: {{forecast.windGust}}
    <br>
    Chance of Rain: {{(forecast.precipProbability*100).toFixed(2)}}%
    <br>
  </div>
</template>
<script>
const axios = require("axios");
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
      apiUrl: "http://localhost:8080/weather.json"
    };
  },
  mounted() {
    setInterval(this.refresh, this.refreshSeconds * 1000);
  },
  methods: {
    refresh() {
      axios.get(this.apiUrl).then(response => {
        const weather = response.data.hourly;
        this.forecast.summary = weather.summary;
        this.forecast.temperature = weather.data[0].temperature;
        this.forecast.windSpeed = weather.data[0].windSpeed;
        this.forecast.windGust = weather.data[0].windGust;
        this.forecast.precipProbability = weather.data[0].precipProbability;
      });
    }
  }
};
</script>



