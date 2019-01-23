<template>
  <p class="text-sm" :class="{'bg-red': error}">
    <strong>{{numberOfLicences}} licences expiring in the next month</strong>
    <br>
    <br>
    <ul>
        <li v-for="licence in licence" :key="licence.id">{{licence.Title}} <br/>{{licence.Description}} Contact:{{licence.Contact}}</li>
    </ul>
    <br>
  </p>
</template>

<script>
var isToday = require('date-fns/is_today')
var isBefore = require('date-fns/is_before')
var isAfter = require('date-fns/is_after')
var parse = require('date-fns/parse')
var addMonths = require('date-fns/add_months')
const axios = require("axios");
export default {
  props: ['refreshSeconds'], 
  mounted() {
    setInterval(this.refresh, this.refreshSeconds*1000);
    let licenceCache = localStorage.getItem("Exiring Licences");
    if (licenceCache){
      this.licence=JSON.parse(licenceCache)
    }
    let lengthCache = localStorage.getItem("No of Exiring Licences");
    if (lengthCache){
      this.numberOfLicences=JSON.parse(lengthCache)
    }

    
    this.refresh();
  },
  
  data() {
    return {
      error:false,
      licence: [{}],
      numberOfLicences:0
      
    };
  },
  methods: {
    refresh() {
      axios
        .get(`http://${process.env.VUE_APP_API_IP}:3003/`)
        .then(response => {
          // handle success
          //console.log(response);
        //   console.log(response.data)
          const licences = response.data.Data;
          const expiringLicenes = licences.filter(lic=>{
              const today = new Date();
              const expiryDate = parse(lic.ExpireDate)
              const expiryMonth= addMonths(today,1)
              //console.log(expiryDate)
              if(isBefore(expiryDate,today))return false

              if(isAfter(expiryDate, expiryMonth)) return false

              return true;


          })
          console.log(expiringLicenes)
         
          this.updateValues(expiringLicenes);
        })
        .catch((error)=> {
          // handle error
          console.log(error);
          this.error=true;
        });
    },
    updateValues(expiringLicences){
      this.licence=expiringLicences;
      this.numberOfLicences= expiringLicences.length;
      localStorage.setItem("Expiring Licences", JSON.stringify(expiringLicences));
      localStorage.setItem("No of Expiring Licences", JSON.stringify(expiringLicences.length));      
      
    }
  }
};
</script>

