<template>
<form @submit.prevent="handleSubmit" class = "signup">
  <div class="container">
    <h1>Reset Password</h1>
    <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Email:" v-model="email" name="email" required>
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
  
  name: 'forgotUser',
  data(){
return {
  email:'',
  // password:'',
  // password2:''
}
  },
  methods:{
async handleSubmit(){
  try{
    // Check if email exists 
    console.log('Button Pressed...')
    const emailcheck = await api.verifyrole(this.email)
    if(emailcheck.role[0].role != null){
      
    }else{
      alert('Email does not exist. Please Sign-Up.')
    }
    // if(this.password == this.password2){
    //   await api.forgot(
    //   this.password,
    //   this.email
    //   )
    //   this.$router.push('/login')
    // }else{
    //   alert("Passwords Do Not Match.")
    // }
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
