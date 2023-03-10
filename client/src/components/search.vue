<template>
  <h2>Search:</h2>
  <form autocomplete="off">
    <div class="autocomplete" style="width: 300px">
      <input
        v-model="searchValue"
        id="myInput"
        type="text"
        name="locationSearch"
        placeholder="Restaurant..."
        @input="
          showResults(searchValue);
          updateList();
        "
      />
    </div>
    <input type="submit" v-show="true" />
    <ul>
      <div
        id="searchResult"
        v-for="location in locations"
        v-bind:key="location"
      >
        <li class="searchItem" @onClick="ShowRestaurant(location)">{{ location }}</li>
      </div>
    </ul>
  </form>
</template>

<script>
export default {
  name: "search",
  props: {
    searchList: String,
  },
  data() {
    return {
      tmplocals: [],
      locations: [],
    };
  },
  async created() {
    // this.searchList.data.forEach((element) =>
    //   this.locations.push(element)
    // );
    // console.log(this.searchList)
    // console.log(this.locations)
  },
  methods: {
    updateList() {
      this.tmplocals = JSON.parse(this.searchList);
      let listitems = this.tmplocals.data;
      return listitems;
    },
    showResults(values) {
      let list = this.updateList();
      let restNames = [];
      if (values == "") {
        this.locations = []
      } else {
        list.forEach((element) => restNames.push(element.restaurantname));
        this.locations = restNames.filter(
          (location) =>
            location.toLowerCase().indexOf(values.toLowerCase()) > -1
        );
      }
    },
  },
};
</script>

<style scoped>
.autocomplete {
  position: relative;
  display: inline-block;
}
input {
  border: 1px solid transparent;
  background-color: #f1f1f1;
  padding: 10px;
  font-size: 16px;
}

input[type="text"] {
  background-color: #f1f1f1;
  width: 100%;
}

input[type="submit"] {
  background-color: DodgerBlue;
  color: #fff;
  cursor: pointer;
}
.autocomplete-items {
  position: absolute;
  border: 1px solid #d4d4d4;
  border-bottom: none;
  border-top: none;
  z-index: 99;
  /*position the autocomplete items to be the same width as the container:*/
  top: 100%;
  left: 0;
  right: 0;
}

.autocomplete-items div {
  padding: 10px;
  cursor: pointer;
  background-color: #fff;
  border-bottom: 1px solid #d4d4d4;
}

/*when hovering an item:*/
.autocomplete-items div:hover {
  background-color: #e9e9e9;
}

/*when navigating through the items using the arrow keys:*/
.autocomplete-active {
  background-color: DodgerBlue !important;
  color: #ffffff;
}
</style>