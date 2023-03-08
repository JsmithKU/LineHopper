<template>
  <!-- Login Form comp here -->
  <form @submit.prevent="handleSubmit">
    <div class="container">
      <label for="email"><b>Email</b></label>
      <input
        type="text"
        placeholder="Enter Username"
        v-model="email"
        name="email"
        required
      />

      <label for="password"><b>Password</b></label>
      <input
        type="password"
        placeholder="Enter Password"
        v-model="password"
        name="password"
        required
      />

      <button type="submit">Login</button>
    </div>
  </form>
  <form @submit.prevent="relog">
    <div class="container">
      <button type="submit">Relog From Token</button>
    </div>
  </form>
  <router-link to="/signup"> Need An Account? Click Here. </router-link>
  <br>
  <router-link to="/forgot"> Forgot Password? Click Here. </router-link>
</template>

<script>
import api from "../api.js";

export default {
  name: "userLogin",
  data() {
    return {
      email: "",
      password: "",
    };
  },
  async created() {
    // try {
    //   await api.refresh()
    //   this.$router.push('/')
    // } catch (err) {
    //   console.log('') // Fix this !!! (Bad bypass for no error catching)
    // }
  },
  async pusher(){
    
  },
  methods: {
    async handleSubmit() {
      try {
        await api.login(this.email, this.password);
        this.$router.push({ path: "/" }); //this.$router.push({name:'/', params: {useremail: this.email}})
      } catch (err) {
        this.error = "HUH";
      }
    },
    async relog() {
      try {
        await api.refresh();
        this.$router.push("/");
      } catch (err) {
        alert('No Token. Please Login or Signup.')
      }
    },
  },
};
</script>
