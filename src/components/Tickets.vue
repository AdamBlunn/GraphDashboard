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
    let statsCache = localStorage.getItem("Stats");
    if (statsCache){
      this.stats=JSON.parse(statsCache)
    }
    let ticketsCache = localStorage.getItem("Tickets");
    if(ticketsCache){
      this.tickets=JSON.parse(ticketsCache);
    }
    this.refresh();
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
         let tempStats = response.data.stats;
         let tempTickets = response.data.tickets.slice(0,5);
         this.error=false;
         
         this.updateValues(tempStats,tempTickets);
        })
        .catch((error)=> {
          // handle error
          console.log(error);
          this.error=true;
        });
    },
    updateValues(newStats,newTickets){
      this.stats=newStats;
      this.tickets=newTickets;
      localStorage.setItem("Stats", JSON.stringify(newStats));
      localStorage.setItem("Tickets",JSON.stringify(newTickets));
    }
  }
};
</script>

