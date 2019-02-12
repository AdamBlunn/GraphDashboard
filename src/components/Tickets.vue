<template>
  <p class="text-md text-center text-white" :class="{'bg-white': error}">
    <strong>{{this.tickets.length}} Tickets to be handled.</strong>
    <br>
    <br>
    <ul class="text-sm text-left ">
        <!-- {{this.tickets[0].title}} -->
        <li class="mb-2 border-b pb-2 text-sm" v-for="ticket in tickets" :key="ticket.link"><span class="text-gold">{{ticket.creator}}</span> - {{ticket.title}} <br/></li>
    </ul>
    <br>
  </p>
</template>

<script>
const axios = require("axios");
const faker = require('faker')
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
    // if (process.env.VUE_APP_ENVIROMENT == 'Demo'){
    //   this.generateFaker()
    // }
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
    // generateFaker(){
    //   let ticket2 =[{
    //     content:faker.lorem.words(),
    //     contentSnippet:faker.lorem.words(),
    //     creator: faker.name.findname(),
    //     date:faker.date.recent(),
    //     // dc:creator:"Stephen Thoms",
    //     // dc:date:"Tue, 12 Feb 2019 08:52:31 +0000",
    //     // isoDate:"2019-02-12T08:52:31.000Z",
    //     // link:"http://oaoa.eng.gla.ac.uk/rt/Ticket/Display.html?id=122718",
    //     title: faker.lorem.words()
        

    //   }]
    //   updateValues(ticket2)

    // },
    updateValues(newTickets){
      // this.stats=newStats;
      let temp=[]
      for (let index = 0; index < 10; index++) {
        temp.push(newTickets[index]);
        
      }
      this.tickets=temp;
      //this.tickets=newTickets;
      // localStorage.setItem("Stats", JSON.stringify(newStats));
      localStorage.setItem("Tickets",JSON.stringify(newTickets));
      
    }
  }
};
</script>