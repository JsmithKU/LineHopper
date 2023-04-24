<template>
  <!-- <div class="hello">
    <h1>{{ msg }}</h1>
  </div> -->
  <div class="dialog" v-show="restdialog">
    <button class="hide-dia" @click="restdialog = false">Close</button>
    <div class="dia-content">
      <div class="" v-for="l in slocation" v-bind:key="l.restaurantid">
        <p class="name">{{ l.restaurantname }}</p>
        <p>Address: {{ l.address }}</p>
        <p v-if="l.busyavg != null">Busy Avg: {{ l.busyavg }} / 5</p>
        <p v-if="l.cleanavg != null">Clean Avg: {{ l.cleanavg }} / 5</p>
        <p>Open:{{ l.openhour }}</p>
        <p>Close:{{ l.closehour }}</p>
        <div>
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
        <locationStat :rid="l.restaurantid" :token="token" />
      </div>
    </div>
  </div>
  <div class="container">
    <search :searchList="locationSearch" @openRestaurant="showRestaurant" />
  </div>
  <h2>Locations</h2>
  <div class="containerloc">
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
      <p v-if="location.busyavg != null">
        Busy Avg: {{ location.busyavg }} / 5
      </p>
      <p v-if="location.cleanavg != null">
        Clean Avg: {{ location.cleanavg }} / 5
      </p>
      <p>{{ location.address }}</p>
      <p>Open:{{ location.openhour }}</p>
      <p>Close:{{ location.closehour }}</p>
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
/* .locations {
  border: 2px solid #c3daf8;
  border-radius: 44px;
  float: left;
  width: 150px;
  height: 300px;
  margin: 10px 10px;
  background-color: white;
  overflow: hidden;
}
.locations:hover {
  background-color: #c3daf8;
  cursor: pointer;
} */
/* .name {
  font-size: 1.8rem;
  background-color: #c3daf8;
  color: #3284f0;
  overflow: hidden;
  width: 100%;
  margin-top: 0;
  padding-top: 12px;
} */
/* .btn-report {
  margin: 10px 10px;
}
.dialog {
  position: absolute;
  width: 100%;
  height: 100%;
  z-index: 9999;
  background: rgba(0, 0, 0, 0.4);
}
.dia-content {
  position: absolute;
  z-index: 10000;
  width: 100%;
  height: 100%;
  max-height: 100%;
  overflow: auto;
  background-color: #c3daf8;
} */
.btn-report {
  margin: 10px 10px;
  padding: 10px 20px;
  background-color: #3284f0;
  color: white;
  border: none;
  border-radius: 5px;
  font-size: 1rem;
}

.dialog {
  position: fixed;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  z-index: 9999;
  background: rgba(0, 0, 0, 0.5);
  display: flex;
  justify-content: center;
  align-items: flex-end;
}

.dia-content {
  position: relative;
  z-index: 10000;
  width: 90%;
  max-width: 600px;
  padding: 20px;
  border-radius: 5px 5px 0 0;
  background-color: white;
  box-shadow: 0 5px 10px rgba(0, 0, 0, 0.2);
  overflow-y: auto;
  max-height: calc(100vh - 100px);
  animation: slide-up 0.3s ease-in-out;
}
.hide-dia {
  position: absolute;
  top: 10px;
  /* right: 10px; */
  font-size: 1.2rem;
  font-weight: bold;
  color: #fff;
  background-color: #3284f0;
  border: none;
  border-radius: 10px;
  padding: 10px 20px;
  cursor: pointer;
}
@media (max-width: 600px) {
  .dia-content {
    max-width: 100%;
  }
}
.hide-dia:hover {
  background-color: #1e5ab9;
}

@keyframes slide-up {
  from {
    transform: translateY(100%);
  }
  to {
    transform: translateY(0);
  }
}

.containerloc {
  display: flex;
  flex-wrap: wrap;
  justify-content: center;
  align-items: center;
  overflow-x: auto;
  white-space: nowrap;
}

.locations {
  display: flex;
  flex-direction: column;
  justify-content: center;
  align-items: center;
  border: 2px solid #c3daf8;
  border-radius: 20px;
  width: 200px;
  height: 300px;
  margin: 10px;
  padding: 10px;
  background-color: white;
  transition: all 0.3s ease;
  box-sizing: border-box;
  position: relative;
}

.locations:hover {
  transform: translateY(-5px);
  box-shadow: 0 10px 20px rgba(0, 0, 0, 0.2);
}

.locations:active {
  background-color: #c3daf8;
}

.name {
  /* font-size: 1.6rem; */
  font-weight: bold;
  color: #3284f0;
  /* background-color: #3284f0; */
  border-radius: 20px 20px 0 0;
  padding: 10px;
  margin-top: 0;
  width: 100%;
}

.locations p {
  margin: 10px 0;
  text-align: center;
}

@media (max-width: 600px) {
  .containerloc {
    display: flex;
    flex-wrap: nowrap; /* prevent wrapping */
    overflow-x: scroll; /* enable horizontal scrolling */
    -webkit-overflow-scrolling: touch; /* enable momentum scrolling on iOS */
    padding-left: 440px; /* add left padding */
  }
  
  .locations {
    flex-shrink: 0; /* prevent resizing */
    margin-right: 10px; /* add some space between boxes */
  }
  
  .locations:first-child {
    margin-left: 10px; /* add left margin to first box */
  }
  
  .locations:last-child {
    margin-right: 0; /* remove margin from the last box */
  }
}
</style>
