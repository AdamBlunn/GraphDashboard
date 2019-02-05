<template>
<div lass="shadow bg-success border-l-8 hover:bg-success-dark border-success-dark mb-2 p-2 md:w-1/4 mx-2">
  <p class="text-sm, text-center" :class="{'bg-red': error}">
    <strong>{{numberOfLicences}} licences expiring in the next month</strong>
    <br>
    <br>
    <ul>
        <li class="mb-3 border-b pb-4" v-for="licence in licence" :key="licence.id">{{licence.Title}} <br/>{{licence.Description}} Contact:{{licence.Contact}} <br/> </li>
        
    </ul><br>
    <strong class="text-grey-lightest">Expired Licences</strong>
    
    <ul>
      <br>
      <li class="mb-3 border-b pb-4" v-for="licence in licenceExpired" :key="licence.id"><br>{{licence.Title}}<br/>{{licence.Description}}<br/> Contact: {{licence.Contact}}<br/>{{licence.ExpireDate}}</li>
    </ul>
    <br>
  </p>
</div>
</template>
<script>
var isToday = require('date-fns/is_today')
var isBefore = require('date-fns/is_before')
var isAfter = require('date-fns/is_after')
var parse = require('date-fns/parse')
var addMonths = require('date-fns/add_months')
var subMonths = require('date-fns/sub_months')
const axios = require("axios");
import proxy from "../modules/cors-client.js";
export default {
  props: ["refreshSeconds", /*"apiconfig"*/],
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
    let expiredLicencesCache= localStorage.getItem("Expired Licences");
    if(lengthCache){
      this.licenceExpired = JSON.parse(expiredLicencesCache)
    }
     this.refresh();
  },
  data() {
    return {
      error:false,
      licence: [{}],
      licenceExpired:[{}],
      numberOfLicences:0,
      licUrl: process.env.VUE_APP_LICENCE_URL
      
    };
  },
  methods: {
    refresh() {
      proxy
        .get(this.licUrl)
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
          const expiredLicences = licences.filter(lic=>{
            const today = new Date();
            const expiryDate = parse(lic.ExpireDate)
            const expiryMonth = subMonths(today, 12)
            if(isBefore(expiryDate, today)){
              if(isBefore(expiryDate, expiryMonth )) return false
            }if(isAfter(expiryDate,today))return false
            
            return true;           
          })
          this.updateValues(expiringLicenes, expiredLicences);
        })
        .catch((error)=> {
          // handle error
          console.log(error);
          this.error=true;
        });
    },
    updateValues(expiringLicences, expiredLicences){
      this.licence=expiringLicences;
      this.licenceExpired = expiredLicences
      this.numberOfLicences= expiringLicences.length;
      localStorage.setItem("Expiring Licences", JSON.stringify(expiringLicences));
      localStorage.setItem("No of Expiring Licences", JSON.stringify(expiringLicences.length)); 
      localStorage.setItem("Expired Licences", JSON.stringify(expiredLicences));     
    }
  }
};
</script>

