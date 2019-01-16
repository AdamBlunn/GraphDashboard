<template>
  <div :class="{'bg-red': error}">
    <apexchart ref="fred" type="line" :options="options" :series="series"></apexchart>
  </div>
</template>

<script>
const axios = require("axios");
export default {
  props: ["refreshSeconds"],
  mounted() {
    //setInterval(this.refresh, 4000);
    this.refresh();
  },
  data() {
    return {
      error: false,
      memoryseries: [],
      loadseries: [],
      value: 0,
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
        // xaxis: {
        //   categories: "values"
        // }
        yaxis: {
          max: 20
        }
      },
      series: [
        {
          name: "Load",
          data: [20]
        },
        {
          name: "Memory usage",
          data: [20]
        }
      ]
    };
  },
  methods: {
    refresh() {
      let start = new Date();

      start.setHours(start.getHours() - 1);
      let end = new Date();
      const startString = start.toISOString();
      const endString = end.toISOString();
      //console.log(startString, endString);
      const url = `http://localhost:9090/api/v1/query_range?query=node_load5{job=%22mymac%22}&start=${startString}&end=${endString}&step=15s`;
      //console.log(url);
      const memurl = `http://localhost:9090/api/v1/query_range?query=node_memory_active_bytes{job=%22mymac%22}&start=2019-01-10T20:10:30.781Z&end=2019-01-11T20:11:00.781Z&step=15s`;
      let newloaddata = [];
      let newmemdata = [];
      axios
        .get(url)
        //load graph call
        .then(response => {
          // handle success
          let temp = [...response.data.data.result[0].values];
          temp.reverse();
          newloaddata = temp
            //.reverse()

            .map(item => {
              return parseFloat(item[1]);
            })
            .slice(0, 20);

          // console.log(response.data.data.result[0].values);
          //console.log(newloaddata);
          this.updateLoadSeries(newloaddata);
          this.error = false;
        })
        .catch(error => {
          // handle error
          console.log(error);
          this.error = true;
        });

      axios
        //memory usage graph call
        .get(memurl)

        .then(response => {
          // handle success
          let temp2 = [...response.data.data.result[0].values];
          temp2.reverse();
          newmemdata = temp2
            //.reverse()

            .map(item => {
              return parseFloat(item[1] / 100000000); //divide data down to palatable level
            })
            .slice(0, 20);
          this.error = false;

          // console.log(response.data.data.result[0].values);
          //console.log(newmemdata);
          this.updateMemorySeries(newmemdata);
        })
        .catch(error => {
          // handle error
          console.log(error);
          this.error = true;
        });
      setTimeout(this.refresh, this.refreshSeconds * 1000);
    },
    updateLoadSeries(newdata) {
      this.loadseries = newdata;

      this.updateGraph();
    },
    updateMemorySeries(newdata) {
      this.memoryseries = newdata;

      this.updateGraph();
    },
    updateGraph() {
      this.$refs.fred.updateSeries([
        {
          data: this.loadseries
        },
        {
          data: this.memoryseries
        }
      ]);
    }
  }
};
</script>