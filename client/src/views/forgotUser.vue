<template>
<form v-if="codeallow" @submit.prevent="handleSubmit" class = "signup">
  <div class="containerl">
    <h1>Reset Password</h1>
    <label for="email"><b>Email</b></label>
    <input type="text" placeholder="Email" v-model="email" name="email" required>
    <button type="submit">Reset account</button>
  </div>
</form>
<forgotform v-else :linkemail="email"/>
<br>
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
.centeredl {
  margin: auto;
  width: 50%;
  padding: 10px;
}
input[type="text"],
select {
  width: 70%;
  padding: 12px 20px;
  margin: 0 15%;
  display: block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
input[type="password"],
select {
  width: 70%;
  padding: 12px 20px;
  margin: 0 15%;
  display: block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

button[type="submit"] {
  width: 50%;
  background-color: #3284f0;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button[type="submit"]:hover {
  background-color: #2a71ce;
}
@media screen and (max-width: 600px) {
  html {
    background-color: #3284f0;
  }
  .containerl {
    background-color: #c3daf8;
    border-radius: 44px;
    padding: 5em;
    box-shadow: 5px 10px #0a0a0a;
  }
  .centeredl {
    margin: auto;
    width: 100%;
    padding: 10px;
  }
  .usernamel {
  }
  .passwordl {
  }
  input[type="text"],
  select {
    width: 70%;
    padding: 12px 20px;
    margin: 0 15%;
    display: block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
  }
  input[type="password"],
  select {
    width: 70%;
    padding: 12px 20px;
    margin: 0 15%;
    display: block;
    border: 1px solid #ccc;
    border-radius: 4px;
    box-sizing: border-box;
  }

  button[type="submit"] {
    width: 50%;
    background-color: #3284f0;
    color: white;
    padding: 14px 20px;
    margin: 8px 0;
    border: none;
    border-radius: 4px;
    cursor: pointer;
  }

  button[type="submit"]:hover {
    background-color: #2a71ce;
  }
}
</style>
