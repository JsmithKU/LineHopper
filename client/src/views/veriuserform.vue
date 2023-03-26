<template>
    <!-- signup Form comp here -->
    <form @submit.prevent="handleSubmit" class = "signup">
  <div class="container">
    <h1>Verify Account</h1>
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
      email: "",
      code: "",
    };
  },
  async created(){
    this.email = atob(this.$route.params.email)
  },
  methods: {
    async handleSubmit() {
      try {
        // Check if email is valid
        const codecheck = await api.codecheck(this.email, this.code)
        if(codecheck.verify == 'true'){
          const verifyrole = await api.verifyrole(this.email)
          if(verifyrole.role[0].role == null){
            // update role 
            console.log('WTF')
            await api.updateuserrole(this.email, this.code)

          }
          this.$router.push('/login')
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
