<template>
  <form @submit.prevent="handleSubmit" class = "signup">
  <div class="containerl">
    <h1>Reset Password</h1>
    <p> Check your email for your code. (It may be in your spam!)</p>
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
</template>

<style scoped>
</style>

<script>
import api from '../api.js'
export default{
  
  name: 'forgotForm',
  props:{
    linkemail: String,
  },
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
    this.email = this.linkemail
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
