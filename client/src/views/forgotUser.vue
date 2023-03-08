<template>
  <!-- signup Form comp here -->
  <form @submit.prevent="handleSubmit" class = "signup">
  <div class="container">
    <h1>Create An Account</h1>
    <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Email:" v-model="email" name="email" required>

    <label for="password"><b>New Password</b></label>
    <input type="password" placeholder="Enter New Password" v-model="password"  name="password" required>
    <label for = "verifyPassword"><b>Verify New Password</b></label>
    <input type = "password" placeholder = "Verify New Password" v-model="password2" name ="verifyPassword" required>

    <button type="submit">Reset account</button>
  </div>
</form>
<router-link to="/login">Remember Login? Click Here. </router-link>


  
</template>

<style scoped>
</style>

<script>
import api from '../api.js'
export default{
  
  name: 'userSignup',
  data(){
return {
  email:'',
  password:'',
  password2:''
}
  },
  methods:{
async handleSubmit(){
  try{
    if(this.password == this.password2){
      await api.forgot(
      this.password,
      this.email
      )
      this.$router.push('/login')
    }else{
      alert("Passwords Do Not Match.")
    }
  }
catch(error){
  this.error = "Invalid credentials. Please try again"

  }
 }
//client src api.js -- write out post /api/useraccount

}
 }
</script>
