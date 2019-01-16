<template>
  <div class="home" id="dashboard">
    <div class="border shadow, bg-grey-lightest">
      <system-load refresh-seconds="10"/>
    </div>
    <div class="border shadow doubleheight bg-grey-lightest">
      <tickets refresh-seconds="10"/>
    </div>
    <div class="border shadow, bg-grey-lightest">
      <cluster-queue refresh-seconds="10"></cluster-queue>
    </div>
    <div class="border shadow, bg-grey-lightest">
      <donut-chart/>
    </div>
    <div class="border shadow, bg-grey-lightest">Hello</div>
    <div class="border shadow, bg-grey-lightest">Hello</div>
    <div class="border shadow, bg-grey-lightest">
      <weather refresh-seconds="10"/>
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

export default {
  name: "home",
  components: {
    HelloWorld,
    SystemLoad,
    DonutChart,
    Tickets,
    ClusterQueue,
    Weather
  }
};
</script>
