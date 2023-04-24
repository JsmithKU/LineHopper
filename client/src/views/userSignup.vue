<template>
  <!-- signup Form comp here -->
  <div class="centeredl">
    <form @submit.prevent="handleSubmit" class="signup">
      <div class="containerl">
        <h1>Create An Account</h1>
        <label for="email"><b>Email</b></label>
        <input
          type="text"
          placeholder="Email:"
          v-model="email"
          name="email"
          required
        />

        <label for="password"><b>Password</b></label>
        <input
          type="password"
          placeholder="Enter Password"
          v-model="password"
          name="password"
          required
        />
        <label for="verifyPassword"><b>Verify Password</b></label>
        <input
          type="password"
          placeholder="Verify password"
          v-model="password2"
          name="verifyPassword"
          required
        />

        <button type="submit">Create account</button>
      </div>
    </form>
    <br>
    <router-link to="/login">Have An Account? Click Here. </router-link>
  </div>
</template>

<script>
import api from "../api.js";
export default {
  name: "userSignup",
  data() {
    return {
      email: "",
      password: "",
      password2: "",
    };
  },
  methods: {
    async handleSubmit() {
      try {
        if (this.password == this.password2) {
          if (this.validateEmail(this.email)) {
            
            await api.signUp(this.email, this.password);
            let crypted = btoa(this.email);
            this.$router.push(`/confirm/${crypted}`);
          } else {
            alert("Bad Email? Not KU Valid.");
          }
        } else {
          alert("Passwords Do Not Match.");
        }
      } catch (error) {
        this.error = "Invalid Email. Please try again. Have An account?";
      }
    },
    validateEmail(email) {
      /* eslint-disable no-useless-escape */
      //const regex = /^[a-zA-Z0-9._%+-]+(@live)?.kutztown.edu$/;
      const regex = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
      return regex.test(email);
    },
    //client src api.js -- write out post /api/useraccount
  },
};
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