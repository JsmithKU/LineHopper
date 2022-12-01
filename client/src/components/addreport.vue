<template>
  <form @submit="onSubmit">
    <label>Restaurant id: </label>
      <input type="text" v-model="restaurantid" name="text" placeholder="Restaurant id"/>
      <div>
  <input type="range" v-model="cleanrank" id="cleanrank" name="cleanrank" 
         min="0.0" max="5.0" step="0.5">
  <label for="cleanrank">clean rank</label>
</div>
  <div>
  <input type="range" v-model="busyrank" id="busyrank" name="busyrank" 
         min="0.0" max="5.0" step="0.5">
  <label for="busyrank">busy rank</label>
</div>
  <input type="submit" value="Submit Report" class="btn"/>

  </form>
</template>

<script>
export default {
  name: 'AddReport',
  data(){
//reportid, restaurantid, cleanrank, busyrank, picture, submissiontime 
    return{
      reportid: Math.floor((Date.now() / 1000) / 2) + Math.floor(Date.now() / 1000),
      restaurantid: '',
      cleanrank: '',
      busyrank: '',
      picture: false,
      submissiontime: new Date().toLocaleString(),

    }
  },
  methods:{
    onSubmit(e){
      e.preventDefault()
        if(!this.restaurantid) {
          alert('missing info.')
          return 
        }
        
      const newReport = {
        reportid: this.reportid,
        restaurantid: this.restaurantid,
        cleanrank: this.cleanrank,
        busyrank: this.busyrank,
        picture: this.picture,
        submissiontime: this.submissiontime,
      }
      this.$emit('submit-report', newReport)
      // reset report form
      this.restaurantid = ''
      this.cleanrank = ''
      this.busyrank = ''

    }

  },
}
</script>

<style scoped>

</style>
<!-- 
  Jake Smith

-->