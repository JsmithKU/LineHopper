<template>
  <!-- signup Form comp here -->
  <form @submit.prevent="handleSubmit" class = "signup">
<div class="container">
  <h1>Trusted User Confirm</h1>
  <!-- <label for="email"><b>Email</b></label>
  <input type="text" placeholder="Email" v-model="email" name="email" required> -->
  <label for="code"><b>Code</b></label>
  <input type="text" placeholder="000000" v-model="code" name="code" required>
  <button type="submit">Verify Account</button>
</div>
</form>
</template>

<style scoped>
</style>

<script>
import api from '../api.js'
export default {
name: "verifyuser",
data() {
  return {
    uuid: "",
    code: "",
  };
},
async created(){
  this.uuid = this.$route.params.uuid
},
methods: {
  async handleSubmit() {
    try {
      // Check if email is valid
      const codecheck = await api.trustedcodecheck(this.uuid, this.code)
      if(codecheck.verify == 'true'){
        this.$router.push('/')
      }else{
        alert('Bad Code.')
        try{
          await api.signout()
          this.$router.push('/login')
        }catch(error){
          this.error = "No login"
          this.$router.push('/login')
        }
      }
    } catch (error) {
      this.error = "Invalid credentials. Please try again";
    }
  },
  //client src api.js -- write out post /api/useraccount
},
};
</script>
<style scoped>
</style>
