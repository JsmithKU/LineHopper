<template>
  <h1> {{msg}} </h1>
  <div class="container">
    <h2> Unchecked Reports </h2>
    <div class="report" v-for="ur in unReports" v-bind:key="ur.reportid">
      <p class="name">Name: {{ur.name}}</p>
      <p> Clean Rank: {{ur.cleanrank}}</p>
      <p>Busy Rank: {{ur.busyrank}}</p>
      <p>{{ur.submissiontime}}</p>
      <button class="btn" @click="onClick(`${ur.reportid}`, `approved`)">Approve</button>
      <button class="btn" @click="onClick(`${ur.reportid}`, `rejected`)">Reject</button>
    </div>
  </div>
</template>

<script>
import api from '../api.js'

export default{
  name: 'adminPage',
  props: {
    msg: String, 

  },
  data(){
    return{
      unReports: [],
      error: '',
      deleted: '',
    }
  },
  async created(){
    try{
      this.unReports = await api.uncheckedreports()
    }catch(err){
      this.error = "borked."
    }
  },
  methods:{
    async onClick(id, ans){
      if(ans == `rejected`){
        // Do Delete
        try{
          this.deleted = await api.deleteunchecked(id)
          alert('REMOVED ID: ' + id)
        }
        catch(err){
          //this.error = "borked."
          alert('Failed to remove: ' + err)
        }
      }
      if(ans == `approved`)
      {
        // Add to reports
        try{
          //console.log(data[0])
          //console.log()
          let data = await api.uncheckreportbyid(id)
          api.approvereport(JSON.stringify(data[0]))
          this.deleted = await api.deleteunchecked(id)
          alert('ADDED ID: ' + id)
        }
        catch(err){
          //this.error = "borked."
          alert('Failed to add: ' + err)
        }
      }
      // another really dumb updater function 
      try{
      this.unReports = await api.uncheckedreports()
      }catch(err){
      this.error = "borked."
      }
    }
  }
}

</script>

<style scoped>
.report{
  border: 1px solid green;
  margin-bottom: 5px;
  padding-bottom: 5px;
}
</style>