<template>
  <p class="text-sm" :class="{'bg-red': error}">
    <strong>{{stats.new_this_week}} New Tickets This Week</strong>
    <br>
    <br>
    <ul>
        <li v-for="ticket in tickets" :key="ticket.id">{{ticket.subject}}</li>
    </ul>
    <br>
  </p>
</template>

<script>
const axios = require("axios");
export default {
  props: ['refreshSeconds'], 
  mounted() {
    setInterval(this.refresh, this.refreshSeconds*1000);
  },
  data() {
    return {
      error:false,
      stats: {},
      tickets: []
    };
  },
  methods: {
    refresh() {
      axios
        .get(`http://${process.env.VUE_APP_API_IP}:3000/`)
        .then(response => {
          // handle success
          //console.log(response);
          this.stats = response.data.stats;
          this.tickets = response.data.tickets.slice(0,5);
          this.error=false

        })
        .catch((error)=> {
          // handle error
          console.log(error);
          this.error=true;
        });
    }
  }
};
</script>

