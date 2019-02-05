<template>
  <div class="home" id="dashboard">
    <div class="border shadow, bg-grey-uni-light load rounded">
      <system-load refresh-seconds="10"/>
    </div>
    <div class="border shadow doubleheight tickets bg-red border-soft-red rounded-lg">
      <tickets refresh-seconds="10"/>
    </div>
    <div class="border shadow, bg-teal-uni border-teal-dark rounded cluster">
      <cluster-queue refresh-seconds="10"></cluster-queue>
    </div>
    <div class="border shadow rounded bg-grey-uni-light border-grey-light labs">
      <labs :apiconfig="apiconfig"/>
    </div>
    <!-- <div class="border shadow, bg-grey-lightest donut rounded">
      <donut-chart/>
    </div>-->
    <div class="border shadow, rounded border-purple bg-blue-uni licences">
      <licences refresh-seconds="1" class="text-justify, text-grey-lightest"/>
    </div>
    <div class="border shadow, bg-blue-uni border-grey container-sm rounded float-right">
      <weather refresh-seconds="10" class="text-grey-lightest text-center"/>
    </div>
  </div>
</template>

<script>
// @ is an alias to /src
import HelloWorld from "@/components/HelloWorld.vue";
import SystemLoad from "@/components/SystemLoad.vue";
import DonutChart from "@/components/DonutChart.vue";
import Tickets from "@/components/Tickets.vue";
import ClusterQueue from "@/components/ClusterQueue.vue";
import Weather from "@/components/Weather.vue";
import Licences from "@/components/Licences.vue";
import Labs from "@/components/Labs.vue";

export default {
  name: "home",
  components: {
    HelloWorld,
    SystemLoad,
    DonutChart,
    Tickets,
    ClusterQueue,
    Weather,
    Licences,
    Labs
  }
};
const apiConfig = {
  weatherUrl: process.env.VUE_APP_WEATHER_URL,
  ticketsUrl: process.env.VUE_APP_TICKETS_URL,
  licenceUrl: process.env.VUE_APP_LICENCE_URL,
  r317Key: process.env.VUE_APP_R317_KEY,
  r317AKey: process.env.VUE_APP_R317A_KEY,
  r329Key: process.env.VUE_APP_R329_KEY,
  r329AKey: process.env.VUE_APP_R329A_KEY,
  r602Key: process.env.VUE_APP_R602_KEY,
  r602AKey: process.env.VUE_APP_R602A_KEY,
  r739Key: process.env.VUE_APP_R739_KEY,
  r739AKey: process.env.VUE_APP_R739A_KEY,
  JWS544Key: process.env.VUE_APP_JWS544_KEY,
  JWS544AKey: process.env.VUE_APP_JWS544A_KEY,
  JWS611Key: process.env.VUE_APP_JWS611_KEY,
  JWS611AKey: process.env.VUE_APP_JWS611A_KEY,
  JWS712Key: process.env.VUE_APP_JWS712_KEY,
  JWS712AKey: process.env.VUE_APP_JWS712A_KEY
};
</script>
<style scoped>
.donut {
  grid-row: 1;
}
.labs {
  grid-row: 1.5;
}
.load {
  grid-row: 1;
}
.cluster {
  grid-row: 1;
}
.tickets {
  grid-row: 3;
}
.licences {
  grid-row: 3;
}
</style>

