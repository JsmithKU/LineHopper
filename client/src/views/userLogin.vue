<template>
  <!-- Login Form comp here -->
  <div class="centeredl">
    <h1>LineHopper KU</h1>
    <form @submit.prevent="handleSubmit">
      <div class="containerl">
        <h2>HOP IN</h2>

        <div class="usernamel">
          <label for="email"><b>Email</b></label>
          <input
            type="text"
            placeholder="Enter Username"
            v-model="email"
            name="email"
            required
          />
        </div>

        <div class="passwordl">
          <label for="password"><b>Password</b></label>
          <input
            type="password"
            placeholder="Enter Password"
            v-model="password"
            name="password"
            required
          />
        </div>
        <button type="submit">Login</button>
      </div>
    </form>
    <form @submit.prevent="relog">
      <div class="relog">
        <button type="submit">Relog From Token</button>
      </div>
    </form>
    <router-link to="/signup"> Need An Account? Click Here. </router-link>
    <br />
    <router-link to="/forgot"> Forgot Password? Click Here. </router-link>
  </div>
</template>

<script>
import api from "../api.js";

export default {
  name: "userLogin",
  data() {
    return {
      email: "",
      password: "",
    };
  },
  async created() {},
  async pusher() {},
  methods: {
    async handleSubmit() {
      try {
        const logmode = await api.login(this.email, this.password);
        //console.log(logmode)
        if (logmode.mode == "trusted") {
          await api.emailcode(this.email);
          this.$router.push(`/trustedconfirm/${logmode.uuid}`);
        } else {
          this.$router.push({ path: "/" });
        }
        //this.$router.push({name:'/', params: {useremail: this.email}})
      } catch (err) {
        if (err == "Account Not Confirmed.") {
          alert("Account Not Confirmed.");
          this.$router.push({ path: "/confirm" });
        }
      }
    },
    async relog() {
      try {
        await api.refresh();
        this.$router.push("/");
      } catch (err) {
        alert("No Token. Please Login or Signup.");
      }
    },
  },
};
</script>
<style>
html {
  background-color: #3284f0;
}
.containerl {
  background-color: #c3daf8;
  border-radius: 44px;
  padding: 5em;
  box-shadow: 5px 10px #0a0a0a;
}
.centeredl{
  margin: auto;
  width: 50%;
  padding: 10px;
}
.usernamel {

}
.passwordl {

}

.relog{
  margin-top: 10px;
}
</style>
<style scoped>
input[type=text], select {
  width: 70%;
  padding: 12px 20px;
  margin: 0 15%;
  display: block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
input[type=password], select {
  width: 70%;
  padding: 12px 20px;
  margin: 0 15%;
  display: block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

button[type=submit] {
  width: 50%;
  background-color: #3284F0;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button[type=submit]:hover {
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
.centeredl{
  margin: auto;
  width: 100%;
  padding: 10px;
}
.usernamel {

}
.passwordl {

}
input[type=text], select {
  width: 70%;
  padding: 12px 20px;
  margin: 0 15%;
  display: block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
input[type=password], select {
  width: 70%;
  padding: 12px 20px;
  margin: 0 15%;
  display: block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}

button[type=submit] {
  width: 50%;
  background-color: #3284F0;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

button[type=submit]:hover {
  background-color: #2a71ce;
}
}
</style>