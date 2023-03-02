<template>
  <form @submit="onSubmit">
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
  props:{
    rid: String,
  },
  data(){
//reportid, restaurantid, cleanrank, busyrank, picture, submissiontime 
    return{
      reportid: parseInt(Math.floor((Date.now() / 1000)) + '' + 1), 
      restaurantid: this.rid,
      cleanrank: '2.5',
      busyrank: '2.5',
      picture: '',
      submissiontime: new Date().toLocaleString(),
      userid: '0',

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
      this.reportid = parseInt(Math.floor((Date.now() / 1000)) + '' + 1)
      this.restaurantid = this.rid
      this.cleanrank = ''
      this.busyrank = ''
      this.submissiontime = new Date().toLocaleString()

    }

  },
}
</script>

<style scoped>

</style>
<!-- 
  Jake Smith

-->