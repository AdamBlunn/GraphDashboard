<template>
  <div :class="{'bg-red': error}">
    <apexchart ref="LabsGraph" type="bar" :options="chartOptions" :series="series"></apexchart>
  </div>
</template>
<script>
const axios = require("axios");
import proxy from "../modules/cors-client.js";
export default {
  props: ["apiconfig"],
  mounted() {
    setInterval(this.getValues, 100000);
    let r329cCache = localStorage.getItem("r329");
    let r329AcCache = localStorage.getItem("r392Active");
    let r317cCache = localStorage.getItem("r317");
    let r317AcCache = localStorage.getItem("r317Active");
    let r602cCache = localStorage.getItem("r602");
    let r602AcCache = localStorage.getItem("r602Active");
    let JWS544cCache = localStorage.getItem("JWS544");
    let JWS544AcCache = localStorage.getItem("JWS544Active");
    let JWS611cCache = localStorage.getItem("JWS611");
    let JWS611AcCache = localStorage.getItem("JWS611Active");
    let JWS712cCache = localStorage.getItem("JWS712");
    let JWS712AcCache = localStorage.getItem("JWS712Active");
    // console.log(apiConfig.r329Key);
    this.getValues();
  },
  data() {
    return {
      error: false,
      // r329Key: process.env.VUE_APP_R329_KEY,
      // r329AKey: process.env.VUE_APP_R329A_KEY,
      // r317Key: process.env.VUE_APP_R317_KEY,
      // r317AKey: process.env.VUE_APP_R317A_KEY,
      // r739Key: process.env.VUE_APP_R739_KEY,
      // r739AKey: process.env.VUE_APP_R739A_KEY,
      // r602Key: process.env.VUE_APP_R602_KEY,
      // r602AKey: process.env.VUE_APP_R602A_KEY,
      // JWS544Key: process.env.VUE_APP_JWS544_KEY,
      // JWS544AKey: process.env.VUE_APP_JWS544A_KEY,
      // JWS611Key: process.env.VUE_APP_JWS611_KEY,
      // JWS611AKey: process.env.VUE_APP_JWS611A_KEY,
      // JWS712Key: process.env.VUE_APP_JWS712_KEY,
      // JWS712AKey: process.env.VUE_APP_JWS712A_KEY,
      r329: 0,
      r329A: 0,
      r317: 0,
      r317A: 0,
      r602: 0,
      r602A: 0,
      JWS544: 0,
      JWS544A: 0,
      JWS611: 0,
      JWS611A: 0,
      JWS712: 0,
      JWS712A: 0,

      chartOptions: {
        chart: {
          stacked: true
        },
        plotOptions: {
          bar: {
            horizontal: true
          }
        },
        xaxis: {
          categories: [
            "Rankine 329",
            "Rankine 317",
            "Rankine 739",
            "Rankine 602",
            "JWS 544",
            "JWS 611",
            "JWS 712"
          ]
        },
        labels: {
          style: {
            colors: "#ffffff"
          }
        }
      },
      series: [
        {
          name: "Active PCs",
          data: [0]
        },
        {
          name: "Free PCs",
          data: [0]
        }
      ]
    };
  },
  methods: {
    getValues() {
      proxy.get(this.apiconfig.r329Key).then(response => {
        this.r329 = response.data;
        //console.log(this.apiconfig);
        localStorage.setItem("r329", JSON.stringify(this.r329));
        this.updateChart();
      });
      proxy.get(this.apiconfig.r329AKey).then(response => {
        this.r329A = response.data;
        localStorage.setItem("r329Active", JSON.stringify(this.r329A));
        this.updateChart();
      });
      proxy.get(this.apiconfig.r317Key).then(response => {
        this.r317 = response.data;
        localStorage.setItem("r317", JSON.stringify(this.r317));
        this.updateChart();
      });
      proxy.get(this.apiconfig.r317AKey).then(response => {
        this.r317A = response.data;
        localStorage.setItem("r317A", JSON.stringify(this.r317A));
        this.updateChart();
      });
      proxy.get(this.apiconfig.r739Key).then(response => {
        this.r739 = response.data;
        localStorage.setItem("r739", JSON.stringify(this.r739));
        this.updateChart();
      });
      proxy.get(this.apiconfig.r739AKey).then(response => {
        this.r739A = response.data;
        localStorage.setItem("r739A", JSON.stringify(this.r739A));
        this.updateChart();
      });
      proxy.get(this.apiconfig.r602Key).then(response => {
        this.r602 = response.data;
        localStorage.setItem("r602", JSON.stringify(this.r602));
        this.updateChart();
      });
      proxy.get(this.apiconfig.r602AKey).then(response => {
        this.r602A = response.data;
        localStorage.setItem("r602A", JSON.stringify(this.r602A));
        this.updateChart();
      });
      proxy.get(this.apiconfig.JWS544Key).then(response => {
        this.JWS544 = response.data;
        localStorage.setItem("JWS544", JSON.stringify(this.JWS544));
        this.updateChart();
      });
      proxy.get(this.apiconfig.JWS544AKey).then(response => {
        this.JWS544A = response.data;
        localStorage.setItem("JWS544A", JSON.stringify(this.JWS544A));
        this.updateChart();
      });
      proxy.get(this.apiconfig.JWS611Key).then(response => {
        this.JWS611 = response.data;
        localStorage.setItem("JWS611", JSON.stringify(this.JWS611));
        this.updateChart();
      });
      proxy.get(this.apiconfig.JWS611AKey).then(response => {
        this.JWS611A = response.data;
        localStorage.setItem("JWS611A", JSON.stringify(this.JWS611A));
        this.updateChart();
      });
      proxy.get(this.apiconfig.JWS712Key).then(response => {
        this.JWS712 = response.data;
        localStorage.setItem("JWS712", JSON.stringify(this.JWS712));
        this.updateChart();
      });
      proxy.get(this.apiconfig.JWS712AKey).then(response => {
        this.JWS712A = response.data;
        localStorage.setItem("JWS712A", JSON.stringify(this.JWS712A));
        this.updateChart();
      });
    },

    updateChart() {
      this.$refs.LabsGraph.updateSeries([
        {
          data: [
            this.r329A,
            this.r317A,
            this.r739A,
            this.r602A,
            this.JWS544A,
            this.JWS611A,
            this.JWS712A
          ]
        },
        {
          data: [
            this.r329 - this.r329A,
            this.r317 - this.r317A,
            this.r739 - this.r739A,
            this.r602 - this.r602A,
            this.JWS544 - this.JWS544A,
            this.JWS611 - this.JWS611A,
            this.JWS712 - this.JWS712A
          ]
        }
      ]);
    }
  }
};
</script>
<style scoped>
</style>

