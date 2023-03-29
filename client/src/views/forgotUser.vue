<template>
<form v-if="codeallow" @submit.prevent="handleSubmit" class = "signup">
  <div class="container">
    <h1>Reset Password</h1>
    <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Email" v-model="email" name="email" required>
    <button type="submit">Reset account</button>
  </div>
</form>
<forgotform v-else />
<router-link to="/login">Remember Login? Click Here. </router-link>
</template>

<style scoped>
</style>

<script>
import api from '../api.js'
import forgotform from '../components/forgotpassform.vue'
export default{
  components: { forgotform },
  
  name: 'forgotUser',
  data(){
return {
  codeallow: true,
  email:'',
  // password:'',
  // password2:''
}
  },
  methods:{
async handleSubmit(){
  try{
    // Check if email exists 
    const emailcheck = await api.emailcheck(this.email)
    if(emailcheck.verify != null){
      const sentemail = await api.emailcode(this.email)
      if(sentemail.status == "true")
      {
        // push user 
        console.log('sent mail.')
        this.codeallow = !this.codeallow
      }
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
