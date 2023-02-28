<template>
  <!-- signup Form comp here -->
  <form @submit.prevent="handleSubmit" class = "signup">
  <div class="container">
    <h1>Create An Account</h1>
    <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Email:" v-model="email" name="email" required>

    <label for="password"><b>Password</b></label>
    <input type="password" placeholder="Enter Password" v-model="password" name="password" required>
    <label for = "verifyPassword"><b>Verify Password</b></label>
    <input type = "password" placeholder = "Verify password" v-model="password" name = "password" required>

    <button type="submit">Create account</button>
  </div>
</form>
<router-link to="/login">Have An Account? Click Here. </router-link>


  
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
  password:''
}

  },
  methods:{

async handleSubmit(){
  try{
    await api.userLogin(
      this.email,
      this.password
      )
  }
catch(error){
  this.error = "Invalid email or password. Try again"

  }
 }
}



 }

</script>






