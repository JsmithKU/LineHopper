<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
  </div>
  <div class="container">
    <h2>Restaurant</h2>
    <div class="" v-for="l in slocation" v-bind:key="l.restaurantid">
      <p class="name">{{ l.restaurantname }}</p>
      <p>Address: {{ l.address }}</p>
      <p>Hours: {{ l.hoursopen }}</p>
      <locationStat :rid="l.restaurantid" :token="token"/>
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
  <div class="container">
    <search :searchList="locationSearch"/>
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
      <p>{{ location.address }}</p>
      <p>{{ location.hoursopen }}</p>
    </div>
  </div>

</template>

<script>
import api from "../api.js";
import addreport from "./addreport.vue";
import locationStat from './locationstatus.vue';
import search from './search.vue';

let refresh = {}
export default {
  components: { addreport, locationStat, search},
  name: "LandingPage",
  props: {
    msg: String,
  },
  emits: ['showRestaurant'],
  data() {
    
    return {
      locations: [],
      slocation: [],
      locationSearch: "",
      error: "",
      showForm: false,
      userid: "",
      token: "",

    };
  },
  async created() {
    try {
      refresh = await api.refresh()
      //console.log(access)
      this.userid = refresh.userid
      this.token = refresh.token
      this.locations = await api.locations(refresh.token)
      //console.log(this.locations); // sanity check
      //this.locationSearch = await api.locationarray()
      // this.locations.data.forEach((element) =>
      //   this.locationSearch.push(element)
      // );
      this.locationSearch = JSON.stringify(this.locations).toString()
    } catch (err) {
      this.error = "borked.";
    }
  },
  methods: {
    async onClick(id) {
      try {
        this.slocation = await api.getlocation(refresh.token,id);//(access, id);
      } catch (err) {
        this.error = "borked.";
      }
    },
    async postReport(form) {
      try {
        let formdata = JSON.stringify(form);
        //console.log(formdata)
        api.postreport(refresh.token,formdata);
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
}
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
  border: 2px solid black;
  overflow: hidden;
  top: 50%;
  left: 50%;
  align-items: center;
  justify-content: center;
}
.locations {
  border: 2px solid black;
  float: left;
  width: 150px;
  height: 300px;
  margin: 10px 10px;
}
.name {
  font-size: 1.8rem;
}
.btn-report {
  margin: 10px 10px;
}
</style>
