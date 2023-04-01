<template>
  <div class="averages">
    <h1> Average Stats </h1>
    <div v-for="s in status" v-bind:key="s.restaurantid">
      <p>Cleanliness Score: {{s.cleanavg}} / 5</p>
      <br>
      <p>Busyness Score: {{s.busyavg}} / 5</p>
      <br>
    </div>
    <!-- <div class="spacer">
    <div id="cleanprogress">
      <div id="cleanlinessBar"></div>
    </div>
    <div id="busyprogress">
      <div id="busynessBar"></div>
    </div>-->
    <div v-for="r in dowreport" v-bind:key="r.restaurantid">
      <h1>{{r.cday}} Averages </h1>
      <p>Cleanliness: {{r.cleanavg}} / 5</p>
      <p>Busyness: {{r.busyavg}} / 5</p>
    </div>
    <div v-for="l in latest" v-bind:key="l.restaurantid">
      <h1> Latest Report </h1>
      <p>Latest Cleanliness: {{l.cleanrank}} / 5</p>
      <p>Latest Busyness: {{l.busyrank}} / 5</p>
      <p> Submission at {{l.shour}}:{{l.sminute}} on {{l.smonth}} {{l.sday}}</p>
    </div>
    <h1> Report History </h1>
    <div v-for="l in historyreport.data" v-bind:key="l.archid">
      <p> {{ l.monthcount }} month(s) ago</p>
      <p>Cleanliness: {{l.monthclean}} / 5</p>
      <p>Busyness: {{l.monthbusy}} / 5</p>
    </div>
  </div>

</template>

<script>
import api from '../api'
export default{
  name: 'locationStatus',
  props:{
    rid: String,
    token: String,
  },
  data(){
    return{
      status: [],
      latest: [],
      error: '',
      dowreport: [],
      historyreport: [],
    }
  },
  async created(){
    try{
      // do stuff
      this.status = await api.getlocationstat(this.token, this.rid)
      this.latest = await api.getlocationlatest(this.token,this.rid)
      this.dowreport = await api.getlocationdowreport(this.token, this.rid)
      this.historyreport = await api.getlocationhistory(this.token,this.rid)
      console.log(this.historyreport)
      console.log(this.historyreport.data)
      // if(this.status[0].cleanavg == 0){
      //   this.status[0].cleanavg = 0
      // }
      // this.cleanbar(this.status[0].cleanavg)
      // this.busybar(this.status[0].busyavg)

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
  transform: translate(-50%, -122px);
  margin-right: 5px;
  border: 1px solid black;
  z-index: -100;
}
#busyprogress {
  width: 100px;
  background-color: #ddd;
  position: absolute;
  left: 50%;
  transform: translate(-50%, -50px);
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