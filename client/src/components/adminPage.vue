<template>
  <h1>{{ msg }}</h1>
  <div class="container">
    <h2>Unchecked Reports</h2>
    <!-- <h3> Token: {{ token }}</h3> -->
    <div v-if="this.error">
      <div class="report" v-for="ur in unReports.data" v-bind:key="ur.reportid">
        <p class="name">Name: {{ ur.restaurantname }}</p>
        <p>Clean Rank: {{ ur.cleanrank }}</p>
        <p>Busy Rank: {{ ur.busyrank }}</p>
        <p>{{ ur.submissiontime }}</p>
        <p>Submitted by: {{ ur.userid }}</p>
        <button class="btn" @click="onClick(`${ur.reportid}`, `approved`)">
          Approve
        </button>
        <button class="btn" @click="onClick(`${ur.reportid}`, `rejected`)">
          Reject
        </button>
      </div>
    </div>
    <div v-else>
      <p>No Reports. If you believe this to be an error try again later.</p>
    </div>
  </div>
</template>

<script>
import api from "../api.js";
let refresh = {};
export default {
  name: "adminPage",
  props: {
    msg: String,
  },
  data() {
    return {
      unReports: [],
      error: true,
      deleted: "",
      token: "",
    };
  },
  async created() {
    try {
      refresh = await api.refresh();
      this.userid = refresh.userid;
      this.token = refresh.token;
      this.unReports = await api.uncheckedreports(refresh.token);
      if (this.unReports.nodata == "True") {
        console.log("No data. Throwing error");
        this.error = false;
        throw new Error("No data");
      }
    } catch (err) {
      this.error = false;
    }
  },
  methods: {
    async onClick(id, ans) {
      if (ans == `rejected`) {
        // Do Delete
        try {
          this.deleted = await api.deleteunchecked(refresh.token, id);
          alert("REMOVED ID: " + id);
        } catch (err) {
          //this.error = "borked."
          alert("Failed to remove: " + err);
        }
      }
      if (ans == `approved`) {
        // Add to reports
        try {
          //console.log(data[0])
          api.approvereport(refresh.token, id);
          alert("APPROVED ID: " + id);
        } catch (err) {
          //this.error = "borked."
          alert("Failed to add: " + err);
        }
      }
      // another really dumb updater function
      try {
        this.unReports = await api.uncheckedreports(refresh.token);
        if (this.unReports.nodata == "True") {
          console.log("No data. Throwing error");
          this.error = false;
          throw new Error("No data");
        }
      } catch (err) {
        this.error = false;
      }
    },
  },
};
</script>

<style scoped>
.report {
  border: 1px solid green;
  margin-bottom: 5px;
  padding-bottom: 5px;
}
.container {
  border: 2px solid black;
  margin-bottom: 10px;
}
</style>