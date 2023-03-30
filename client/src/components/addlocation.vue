<template>
  <form @submit="locationAdd" ref="loc">
    <label for="rname">Restaurant Name:</label>
    <input type="text" v-model="rname" id="rname" name="rname">
    <label for="raddress">Restaurant address:</label>
    <input type="text" v-model="raddress" id="raddress" name="raddress">
    <label for="ropen">OpenTime (00:00:00):</label>
    <input type="text" v-model="ropen" id="ropen" name="ropen">
    <label for="rclose">CloseTime (00:00:00):</label>
    <input type="text" v-model="rclose" id="rclose" name="rclose">
  <input type="submit" value="Add Location" class="btn"/>
  </form>
</template>

<script>
import api from '../api.js'
export default {
  name: 'AddLocation',
  props:{
  },
  data(){
    return{
      rid: 0,
      lid: 0,
      rname: "",
      raddress: "",
      ropen: "",
      rclose: "",
    }
    },
    methods:{
      async locationAdd(e){
        e.preventDefault()
        const newLocation = {
          rid: parseInt(Math.floor((Date.now() / 1000)) + '' + 1),
          lid: parseInt(Math.floor((Date.now() / 1000)) + '' + 2),
          rname: this.rname,
          raddress: this.raddress,
          ropen: this.ropen,
          rclose: this.rclose,
        }
        this.$refs.loc.reset();
        try{
          let form = JSON.stringify(newLocation)
          await api.addlocation(form)
        }catch(error){
          console.log("Relation Issues. Ignoring.")
        }
      }
    }
}

</script>
<style scoped>
  input[type=text], select {
  width: 100%;
  padding: 12px 20px;
  margin: 8px 0;
  display: inline-block;
  border: 1px solid #ccc;
  border-radius: 4px;
  box-sizing: border-box;
}
input[type=submit] {
  width: 100%;
  background-color: #04AA6D;
  color: white;
  padding: 14px 20px;
  margin: 8px 0;
  border: none;
  border-radius: 4px;
  cursor: pointer;
}

input[type=submit]:hover {
  background-color: #45a049;
}
form{
  border-radius: 5px;
  background-color: #f2f2f2;
  padding: 20px;
}
</style>