<template>
  <p class="text-md text-center" :class="{'bg-white': error}">
    <strong>{{this.tickets.length}} Tickets to be handled.</strong>
    <br>
    <br>
    <ul class="text-sm ">
        <!-- {{this.tickets[0].title}} -->
        <li class="mb-3 border-b pb-3" v-for="ticket in tickets" :key="ticket.link">{{ticket.title}} <br>creator: {{ticket.creator}}<br/><br/></li>
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
    // let statsCache = localStorage.getItem("Stats");
    // if (statsCache){
    //   this.stats=JSON.parse(statsCache)
    // }
    let ticketsCache = localStorage.getItem("Tickets");
    if(ticketsCache){
      this.tickets=JSON.parse(ticketsCache);
    }
    this.refresh();
  },

  data() {
    return {
      error:false,
      // stats: {},
      tickets: []
    };
  },
  methods: {
    refresh() {
      axios
        .get(`http://${process.env.VUE_APP_API_IP}:3018/`)
        .then(response => {
          // handle success
          //console.log(response);
         let ticket = response.data.items
        //  let stats = 0
         this.error=false;        
         this.updateValues(ticket);
        })
        .catch((error)=> {
          // handle error 
          console.log(error);
          this.error=true;
        });
    },
    updateValues(newTickets){
      // this.stats=newStats;
      this.tickets=newTickets;
      // localStorage.setItem("Stats", JSON.stringify(newStats));
      localStorage.setItem("Tickets",JSON.stringify(newTickets));
    }
  }
};
</script>