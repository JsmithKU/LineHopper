<template>
  <div class="hello">
    <h1>{{ msg }}</h1>
  </div>
  <div class="container">
    <h2>Locations</h2>
    <hr>
    <!-- <div class="locations">
      <div class="location" 
        v-for="(location, index) in locations" 
        v-bind:item="location" 
        v-bind:index="index" 
        v-bind:key="location.restaurantsid">
        <p class="address">{{location.address}}</p>
      </div>
    </div> -->
    <!-- <p>{{locations}}</p> -->
    <div class="locations" v-for="location in locations" v-bind:key="location.restaurantsid">
      <p>{{location.name}}</p>
      <p>{{location.address}}</p>
      <p>{{location.hoursopen}}</p>
      <p>{{location.restaurantsid}}</p>
    </div>
  </div>
</template>

<script>
import api from '../api.js';

export default {
  name: 'LandingPage',
  props: {
    msg: String
  },
  data(){
    return {
      locations: [],
      error: '',
    }
  },
  async created(){
    try{
      this.locations = await api.locations()
    }catch(err){
      this.error = "borked."
    }
  }
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
.locations{
  border: 2px solid black;
}
</style>
