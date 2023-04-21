<template>
  <div class="aligner">
    <div class="row">
      <div class="aligner-item">
        <BarChart v-if="loadedchart" :chartData="xchartData" />
        <p v-else>Chart has limited data or no data.</p>
      </div>
      <div v-if="loadedavg" class="aligner-item">
        <h1>Average Stats</h1>
        <div v-for="s in status" v-bind:key="s.restaurantid">
          <p>Cleanliness Score: {{ s.cleanavg }} / 5</p>
          <br />
          <p>Busyness Score: {{ s.busyavg }} / 5</p>
          <br />
        </div>
      </div>
      <div v-else class="aligner-item">
        <h1>Average Stats</h1>
        <p>Lacking Enough Data. Submit a report to help.</p>
      </div>
      <div v-if="loadeddow" class="aligner-item">
        <div v-for="r in dowreport" v-bind:key="r.restaurantid">
          <h1>{{ r.cday }} Averages</h1>
          <p>Cleanliness: {{ r.cleanavg }} / 5</p>
          <p>Busyness: {{ r.busyavg }} / 5</p>
        </div>
      </div>
      <div v-else class="aligner-item">
        <h1>Daily Stats</h1>
        <p>Lacking Enough Data. Submit a report to help.</p>
      </div>
      <div v-if="loadedlastest" class="aligner-item">
        <div v-for="l in latest" v-bind:key="l.restaurantid">
          <h1>Latest Report</h1>
          <p>Latest Cleanliness: {{ l.cleanrank }} / 5</p>
          <p>Latest Busyness: {{ l.busyrank }} / 5</p>
          <p>
            Submission at {{ l.shour }}:{{ l.sminute }} on {{ l.smonth }}
            {{ l.sday }}
          </p>
        </div>
      </div>
      <div v-else class="aligner-item">
        <h1>Latest Report</h1>
        <p>Lacking Enough Data. Submit a report to help.</p>
      </div>
      <div v-if="loadedhistory" class="aligner-item">
        <h1>Report History</h1>
        <div v-for="l in historyreport.data" v-bind:key="l.archid">
          <p>{{ l.monthcount }} month(s) ago</p>
          <p>Cleanliness: {{ l.monthclean }} / 5</p>
          <p>Busyness: {{ l.monthbusy }} / 5</p>
        </div>
      </div>
      <div v-else class="aligner-item">
        <h1>History</h1>
        <p>Lacking Enough Data.</p>
      </div>
    </div>
  </div>
</template>

<script>
import api from "../api";
import BarChart from "./barchart.vue";
//Import chart component
//import { Bar } from 'vue-chartjs'

export default {
  name: "locationStatus",
  components: { BarChart },
  props: {
    rid: String,
    token: String,
  },
  data() {
    return {
      ridbuffer: this.rid,
      status: [],
      latest: [],
      error: "",
      dowreport: [],
      historyreport: [],
      xchartData: {},
      loadedchart: false,
      loadedavg: false,
      loadeddow: false,
      loadedlastest: false,
      loadedhistory: false,
    };
  },
  async created() {
    try {
      this.status = await api.getlocationstat(this.token, this.rid);
      this.loadedavg = true
    } catch (e) {
      console.log(e);
    }
    try {
      this.latest = await api.getlocationlatest(this.token, this.rid);
      this.loadedlastest = true
    } catch (e) {
      console.log(e);
    }
    try {
      this.dowreport = await api.getlocationdowreport(this.token, this.rid);
      this.loadeddow = true
    } catch (e) {
      console.log(e);
    }
    try {
      this.historyreport = await api.getlocationhistory(this.token, this.rid);
      this.loadedhistory = true
    } catch (e) {
      console.log(e);
    }
  },
  async mounted() {
    try {
      const cd = await api.getChartData(this.rid);
      //console.log(cd.data)
      let tmpformat = cd.data;
      let xlabels = [];
      let xbusy = [];
      let xclean = [];
      tmpformat.forEach((day) => {
        xlabels.push(day.dayname);
        xbusy.push(day.busyavg);
        xclean.push(day.cleanavg);
      });
      //console.log(labels)
      //console.log(data)
      this.xchartData = {
        labels: xlabels,
        datasets: [
          {
            label: "Busy",
            backgroundColor: "#0317fc",
            data: xbusy,
          },
          {
            label: "Clean",
            backgroundColor: "#fa970c",
            data: xclean,
          },
        ],
      };
      this.loadedchart = true;
      //console.log(this.xchartData)
    } catch (e) {

      console.log(e);
    }
  },
  methods: {
    async cleanbar(cavg) {
      //alert(cavg)
      let elem = document.getElementById("cleanlinessBar");
      elem.style.width = cavg * 20 + "%";
    },
    async busybar(bavg) {
      //alert(cavg)
      let elem = document.getElementById("busynessBar");
      elem.style.width = bavg * 20 + "%";
    },
  },
};
</script>

<style scoped>
.aligner {
  padding: 0;
  margin: 0;
  display: flex;
  align-items: center;
  justify-content: center;
}
.row {
  max-width: 50%;
}
.aligner-item {
  padding: 5px;
  margin: 10px;
  text-align: center;
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
