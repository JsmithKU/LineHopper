<template>
  <!-- Login Form comp here -->
  <form @submit.prevent="handleSubmit">
  <div class="container">
    <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Enter Username" v-model="email" name="email" required>

    <label for="password"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" v-model="password" name="password" required>

    <button type="submit">Login</button>
  </div>
</form>
  <router-link to="/signup"> Need An Account? Click Here. </router-link>
</template>

<script>
import api from '../api.js'
export default{
  name: 'userLogin',
  data() {
    return{
      email: '',
      password: ''
    }
  },
  methods:{
    async handleSubmit(){
      try{
        await api.login(
          this.email,
          this.password
        )
      }catch(err){
        this.error = "HUH"
      }
    }
  }
}
</script>
