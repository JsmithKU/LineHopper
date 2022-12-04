<template>
  <div class="averages">
    <h1> Average Stats </h1>
    <div v-for="s in status" v-bind:key="s.restaurantid">
      <p>Average Cleanliness</p>
      <p> {{s.cleanavg}} / 5</p>
      <p>Average Busyness</p>
      <p> {{s.busyavg}} / 5</p>
    </div>
    <div class="spacer">
    <div id="cleanprogress">
      <div id="cleanlinessBar"></div>
    </div>
    <div id="busyprogress">
      <div id="busynessBar"></div>
    </div>
  </div>
  </div>


</template>

<script>
import api from '../api'
export default{
  name: 'locationStatus',
  props:{
    rid: String,

  },
  data(){
    return{
      status: [],
      latest: [],
      error: '',

    }
  },
  async created(){
    try{
      // do stuff
      this.status = await api.getlocationstat(this.rid)
      if(this.status[0].cleanavg == 0){
        this.status[0].cleanavg = 0
      }
      this.cleanbar(this.status[0].cleanavg)
      this.busybar(this.status[0].busyavg)

    }catch(err){
      this.error = "borked."
    }
  },
  methods:{
    async cleanbar(cavg){
      //alert(cavg)
      let elem = document.getElementById("cleanlinessBar")
      elem.style.width = (cavg * 20) + '%'
    },
    async busybar(bavg){
      //alert(cavg)
      let elem = document.getElementById("busynessBar")
      elem.style.width = (bavg * 20) + '%'
    }
  }
}
</script>

<style scoped>
.averages{
  border: 2px solid orangered;
  padding: 15px 15px;
  padding-bottom: 50px;
}
.spacer{
}
#cleanprogress {
  width: 100px;
  background-color: #ddd;
  position: absolute;
  left: 50%;
  transform: translate(-50%, -110px);
  margin-right: 5px;
  border: 1px solid black;
  z-index: -100;
}
#busyprogress {
  width: 100px;
  background-color: #ddd;
  position: absolute;
  left: 50%;
  transform: translate(-50%, -42px);
  border: 1px solid black;
  z-index: -100;
}
#cleanlinessBar {
  width: 1%;
  height: 30px;
  background-color: #2885d1;
  z-index: -50;
}
#busynessBar {
  width: 1%;
  height: 30px;
  background-color: #cfaa2f;
  z-index: -50;
}
</style>