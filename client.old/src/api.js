import axios from 'axios';

const url = 'http://localhost:3000/'

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
      const promise = axios.get(`${url}location/`)

      // using .then, create a new promise which extracts the data
      const dataPromise = promise.then((response) => response.data)
  
      // return it
      return dataPromise
  }
  static getlocation(id){
    // create a promise for the axios request
    const promise = axios.get(`${url}location/${id}`)

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
}
  // post content
  static postreport(form){
    const res = axios.post(`${url}uncheckedreports`,form, {
      headers: {
        'Content-Type': 'application/json'
      }
    })
    return res.data.data
  }

  static uncheckedreports(){
    // create a promise for the axios request
    const promise = axios.get(`${url}uncheckedreports/`)

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
}
  static uncheckreportbyid(id){
        // create a promise for the axios request
        const promise = axios.get(`${url}uncheckedreports/${id}`)

        // using .then, create a new promise which extracts the data
        const dataPromise = promise.then((response) => response.data)
    
        // return it
        return dataPromise
  }
  static deleteunchecked(id){
    const res = axios.delete(`${url}uncheckedreports/${id}`)
    return res.status
  }

  static approvereport(form){
    const res = axios.post(`${url}finalizedreports`,form, {
      headers: {
        'Content-Type': 'application/json'
      }
    })
    return res.data
  }
  
  static getlocationstat(id){
            // create a promise for the axios request
            const promise = axios.get(`${url}locationstats/${id}`)

            // using .then, create a new promise which extracts the data
            const dataPromise = promise.then((response) => response.data)
        
            // return it
            return dataPromise
  }

  static getlocationlatest(id){
    // create a promise for the axios request
    const promise = axios.get(`${url}locationlatest/${id}`)

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
}

  static getlocationdowreport(id){
        // create a promise for the axios request
        const promise = axios.get(`${url}locationdow/${id}`)

        // using .then, create a new promise which extracts the data
        const dataPromise = promise.then((response) => response.data)
    
        // return it
        return dataPromise
  }
}

export default api