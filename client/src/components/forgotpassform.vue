<template>
  <form @submit.prevent="handleSubmit" class = "signup">
  <div class="container">
    <h1>Reset Password</h1>
    <!-- <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Email" v-model="email" name="email" required> -->
    <label for="code"><b>Code</b></label>
    <input type="text" placeholder="Code" v-model="code" name="code" required>
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
  
  name: 'forgotForm',
  data(){
return {
  email:'',
  password:'',
  code: '',
  password2:''
}
  },
  methods:{
async handleSubmit(){
  try{
    // Need to send out email with code in order to get to the full version
    
    if(this.password == this.password2){
      await api.forgot(
      this.password,
      this.email,
      this.code
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
<style scoped>

</style>
