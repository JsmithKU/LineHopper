<template>
  <!-- <form class="reportform" @submit="onSubmit">
      <div>
  <input class="cleanslider" type="range" v-model="cleanrank" id="cleanrank" name="cleanrank" 
         min="0.0" max="5.0" step="0.5">
  <label for="cleanrank">clean rank</label>
</div>
  <div>
  <input class="busyslider" type="range" v-model="busyrank" id="busyrank" name="busyrank" 
         min="0.0" max="5.0" step="0.5">
  <label for="busyrank">busy rank</label>
</div>
  <input class="formsubmit" type="submit" value="Submit Report"/>
  </form> -->

  <form class="reportform" @submit="onSubmit">
  <div>
    <label for="cleanrank">Cleanliness:</label>
    <div class="slider-container">
      <input class="cleanslider" type="range" v-model="cleanrank" id="cleanrank" name="cleanrank" 
         min="0.0" max="5.0" step="0.5">
      <output>{{ cleanrank }}</output>
    </div>
  </div>
  <br>
  <div>
    <label for="busyrank">Busyness:</label>
    <div class="slider-container">
      <input class="busyslider" type="range" v-model="busyrank" id="busyrank" name="busyrank" 
         min="0.0" max="5.0" step="0.5">
      <output>{{ busyrank }}</output>
    </div>
  </div>
  <input class="formsubmit" type="submit" value="Submit Report" />
</form>

</template>

<script>

export default {
  name: 'AddReport',
  props:{
    rid: String,
    uuid: String,

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
      userid: this.uuid,

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
        userid: this.userid,
      }
      this.$emit('submit-report', newReport)
      // reset report form
      this.reportid = parseInt(Math.floor((Date.now() / 1000)) + Math.floor((Date.now() / 10000)) + Math.floor((Date.now() / 10000)) )
      this.restaurantid = this.rid
      this.cleanrank = ''
      this.busyrank = ''
      this.submissiontime = new Date().toLocaleString()

    }

  },
}
</script>

<style scoped>
.reportform {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  margin: 0 auto;
  max-width: 600px;
  width: 100%;
}

label {
  display: block;
  margin-bottom: 0.5rem;
  font-weight: bold;
}

.slider-container {
  position: relative;
  width: 100%;
}

input[type="range"] {
  width: 100%;
  margin-bottom: 1rem;
  /* -webkit-appearance: none; */
  background-color: #296bc2;
  height: 6px;
  border-radius: 6px;
  outline: none;
}

input[type="range"]::-webkit-slider-thumb {
  /* -webkit-appearance: none;
  appearance: none; */
  width: 16px;
  height: 16px;
  background-color: #296bc2;
  border-radius: 50%;
  border: none;
}

input[type="range"]::-moz-range-thumb {
  width: 16px;
  height: 16px;
  background-color: #296bc2;
  border-radius: 50%;
  border: none;
}

output {
  display: block;
  margin-top: 0.5rem;
  font-weight: bold;
}

.formsubmit {
  background-color: #3284f0;
  color: white;
  border: none;
  padding: 1rem 2rem;
  border-radius: 4px;
  font-size: 1rem;
  cursor: pointer;
  transition: all 0.3s ease;
}

.formsubmit:hover {
  background-color: #296bc2;
}

</style>