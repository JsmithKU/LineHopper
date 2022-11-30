import axios from 'axios';

const url = 'http://localhost:3000/location/'

class api{
  // get content 
  // static getLocations(){
  //   return new Promise((resolve, reject) =>{
  //     try{
  //       const res = axios.get(`${url}`)
  //       console.log(res)
  //       const data = res.then((r))
  //       console.log(data)
  //       resolve(
  //         data.map(location => ({
  //           ...location
  //         }))
  //       )
  //     } catch(err){
  //       reject(err)
  //     }
  //   })
  // }
  static locations(){
      // create a promise for the axios request
      const promise = axios.get(`${url}`)

      // using .then, create a new promise which extracts the data
      const dataPromise = promise.then((response) => response.data)
  
      // return it
      return dataPromise
  }
  // post content

  // etc 
  // to-dos
}

export default api