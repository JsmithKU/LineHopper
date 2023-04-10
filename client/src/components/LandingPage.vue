<template>
  <!-- <div class="hello">
    <h1>{{ msg }}</h1>
  </div> -->
  <div class="dialog" v-show="restdialog">
    <button @click="restdialog = false">Close</button>
    <div class="dia-content">
      <div class="" v-for="l in slocation" v-bind:key="l.restaurantid">
        <p class="name">{{ l.restaurantname }}</p>
        <p>Address: {{ l.address }}</p>
        <p>Busy Avg: {{ l.busyavg }} / 5</p>
      <p>Clean Avg: {{ l.cleanavg }} / 5</p>
      <p>Open:{{ l.hoursopen }}</p>
      <p>Close:{{ l.hoursclose }}</p>
        <locationStat :rid="l.restaurantid" :token="token" />

        <button class="btn-report" @click="toggleshowform()">
          Submit Report
        </button>
        <addreport
          :rid="l.restaurantid"
          :uuid="userid"
          v-show="showForm"
          @submit-report="postReport"
        />
      </div>
    </div>
  </div>
  <div class="container">
    <search :searchList="locationSearch" @openRestaurant="showRestaurant" />
  </div>
  <div class="container">
    <h2>Locations</h2>
    <div v-for="msg in locations.nodata" v-bind:key="msg.nodata">
      <!-- Clean this up-->
      <p class="name">No Data</p>
    </div>
    <div
      @click="
        onClick(location.restaurantid);
        toggleshowformcloser();
      "
      class="locations"
      v-for="location in locations.data"
      v-bind:key="location.restaurantid"
    >
      <p class="name">{{ location.restaurantname }}</p>
      <p>Busy Avg: {{ location.busyavg }} / 5</p>
      <p>Clean Avg: {{ location.cleanavg }} / 5</p>
      <p>{{ location.address }}</p>
      <p>Open:{{ location.hoursopen }}</p>
      <p>Close:{{ location.hoursclose }}</p>

    </div>
  </div>
</template>

<script>
import api from "../api.js";
import addreport from "./addreport.vue";
import locationStat from "./locationstatus.vue";
import search from "./search.vue";

let refresh = {};
export default {
  components: { addreport, locationStat, search },
  name: "LandingPage",
  props: {
    msg: String,
  },
  data() {
    return {
      locations: [],
      slocation: [],
      locationSearch: "",
      error: "",
      showForm: false,
      restdialog: false,
      userid: "",
      token: "",
    };
  },
  async created() {
    try {
      refresh = await api.refresh();
      //console.log(access)
      this.userid = refresh.userid;
      this.token = refresh.token;
      this.locations = await api.locations(refresh.token);
      //console.log(this.locations); // sanity check
      //this.locationSearch = await api.locationarray()
      // this.locations.data.forEach((element) =>
      //   this.locationSearch.push(element)
      // );
      this.locationSearch = JSON.stringify(this.locations).toString();
    } catch (err) {
      this.error = "borked.";
    }
  },
  methods: {
    async showRestaurant(id) {
      console.log("ShowRestaurant");
      this.restdialog = true;
      try {
        let getid = await api.getlocationid(refresh.token, id);
        this.slocation = await api.getlocation(
          refresh.token,
          getid.data.restaurantid
        ); //(access, id);
      } catch (err) {
        this.error = "borked.";
      }
    },
    async onClick(id) {
      try {
        this.restdialog = true;
        this.slocation = await api.getlocation(refresh.token, id); //(access, id);
      } catch (err) {
        this.error = "borked.";
      }
    },
    async postReport(form) {
      try {
        let formdata = JSON.stringify(form);
        //console.log(formdata)
        api.postreport(refresh.token, formdata);
      } catch (err) {
        this.error = "borked.";
      }
      this.toggleshowformcloser();
    },
    toggleshowform() {
      this.showForm = !this.showForm;
    },
    toggleshowformcloser() {
      this.showForm = false; // really bad way of closing on new location selection
    },
  },
};
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
h3 {
  margin: 40px 0 0;
}
ul {
  list-style-type: none;
  padding: 0;
}
li {
  display: inline-block;
  margin: 0 10px;
}
a {
  color: #42b983;
}
.container {
  overflow: hidden;
  top: 50%;
  left: 50%;
  align-items: center;
  justify-content: center;
}
.locations {
  border: 2px solid #C3DAF8;
  border-radius: 44px;
  float: left;
  width: 150px;
  height: 300px;
  margin: 10px 10px;
  background-color: white;
  overflow: hidden;
}
.locations:hover{
  background-color: #C3DAF8;
  cursor: pointer;
}
.name {
  font-size: 1.8rem;
  background-color: #C3DAF8;
  color: #3284F0;
  overflow: hidden;
  width: 100%;
  margin-top: 0;
  padding-top: 12px;
}
.btn-report {
  margin: 10px 10px;
}
.dialog {
  position: absolute;
  width: 100%;
  height: 100%;
  z-index: 9999;
  background: rgba(0, 0, 0, 0.4);
}
.dia-content{
  position: absolute;
  z-index: 10000;
  width: 100%;
  height: 100%;
  max-height: 100%;
  overflow: auto;
  background-color: #C3DAF8;
}
</style>
