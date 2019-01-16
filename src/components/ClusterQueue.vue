<template>
  <div :class="{'bg-red': error}">
    <apexchart ref="clusterChart" type="bar" :options="options" :series="series"></apexchart>
  </div>
</template>

<script>
const axios = require("axios");
export default {
  props: ["refreshSeconds"],
  mounted() {
    setInterval(this.refresh, this.refreshSeconds * 1000);
  },
  data() {
    return {
      error: false,
      pending: 0,
      running: 0,
      options: {
        chart: {
          animations: {
            enabled: true,
            easing: "linear",
            dynamicAnimation: {
              speed: 700
            }
          },
          toolbar: {
            show: false
          },
          zoom: {
            enabled: false
          }
        },
        xaxis: {
          categories: ["Pending", "Running"]
        }
      },
      series: [
        {
          name: "series-1",
          data: [0, 0]
        }
      ]
    };
  },
  methods: {
    refresh() {
      axios
        .get(`http://${process.env.VUE_APP_API_IP}:3001/`)
        .then(response => {
          // handle success

          // this.series[0].data[0] = response.data.stats.pending;
          // this.series[0].data[1] = response.data.stats.running;
          this.$refs.clusterChart.updateSeries([
            {
              data: [response.data.stats.pending, response.data.stats.running]
            }
          ]);
          this.error = false;
        })
        .catch(error => {
          // handle error
          console.log(error);
          this.error = true;
        });
    }
  }
};
</script>