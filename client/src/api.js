import axios from 'axios';

const url = 'http://localhost:3000/api/'

axios.defaults.withCredentials = true
class api {
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
  static locations(token) {
    // create a promise for the axios request
    const promise = axios.get(`${url}location/`, {
      headers: { Authorization: `Bearer ${token}` }
    })

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
  }
  static getlocation(token,id) {
    // create a promise for the axios request
    const promise = axios.get(`${url}location/${id}`, {
      headers: { Authorization: `Bearer ${token}` }
    })

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
  }
  static getlocationid(token,id) {
    // create a promise for the axios request
    const promise = axios.get(`${url}location/name/${id}`, {
      headers: { Authorization: `Bearer ${token}` }
    })

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
  }
  static locationarray() {
    const promise = axios.get(`${url}location/`)

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
  }
  // post content
  static postreport(token,form) {
    const res = axios.post(`${url}uncheckedreports`, form, {
      headers: {
        'Content-Type': 'application/json',
        Authorization: `Bearer ${token}`
      }
    })
    return res.data.data
  }

  static uncheckedreports(token) {
    // create a promise for the axios request
    const promise = axios.get(`${url}uncheckedreports/`, {
      headers: { Authorization: `Bearer ${token}` }
    })

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
  }

  static uncheckreportbyid(token,id) {
    // create a promise for the axios request
    const promise = axios.get(`${url}uncheckedreports/${id}`, {
      headers: { Authorization: `Bearer ${token}` }
    })

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
  }
  static deleteunchecked(token,id) {
    const res = axios.delete(`${url}uncheckedreports/${id}`, {
      headers: { Authorization: `Bearer ${token}` }
    })
    return res.status
  }

  static approvereport(token, id) {
    // ok. This is fixed, put requests are as follows: url, param, headers. Even if param is baked into url 
    // you need the data even if empty.
    const res = axios.put(`${url}finalizedreports/${id}`,{}, {
      headers: {
        Authorization: `Bearer ${token}`
      }
    })
    return res.data
  }

  static getlocationstat(token,id) {
    // create a promise for the axios request
    const promise = axios.get(`${url}locationstats/`,{
      params:{
        id
      },
      headers: { Authorization: `Bearer ${token}` }
    })

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
  }

  static getlocationlatest(token,id) {
    // create a promise for the axios request
    const promise = axios.get(`${url}locationlatest/${id}`, {
      headers: { Authorization: `Bearer ${token}` }
    })

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
  }

  static getlocationdowreport(token,id) {
    // create a promise for the axios request
    const promise = axios.get(`${url}locationdow/`, id,{
      headers: { Authorization: `Bearer ${token}` }
    })

    // using .then, create a new promise which extracts the data
    const dataPromise = promise.then((response) => response.data)

    // return it
    return dataPromise
  }
  static signUp(email, password) {
    const usercode = Math.floor(100000 + Math.random() * 900000)
    const promise = axios.post(`${url}useraccount`, {
      email,
      password,
      usercode
    })
    const dataPromise = promise.then((response) => response.data)
    return dataPromise

  }
  static login(email, password) {
    const promise = axios.post(`${url}login`, {
      email, password
    })
    const dataPromise = promise.then((response) => response.data)

    return dataPromise
  }
  
  static refresh() {
    const promise = axios.get(`${url}refresh`, {

    })
    const dataPromise = promise.then((response) => response.data)
    return dataPromise
  }
  static signout() {
    const promise = axios.delete(`${url}signout`, {

    })
    const dataPromise = promise.then((response) => response.data)
    return dataPromise
  }
  // FORGOT NEEDS CODE 
  static forgot(password, email){ //, usercode) {
    //const verifycode = axios.get('')
    const promise = axios.put(`${url}useraccount/forgotpassword`,{
      password, email 
    }, {
      
    })
    const dataPromise = promise.then((response) => response.data)
    return dataPromise

  }
  static role(token, userid){
    const promise = axios.get(`${url}userrole/${userid}`,{
    headers: { Authorization: `Bearer ${token}` }
    })
    const dataPromise = promise.then((response) => response.data)
    return dataPromise
  }
  static codecheck(useremail,usercode){
    const promise = axios.get(`${url}verify/${useremail}/${usercode}`,{
    })
    const dataPromise = promise.then((response) => response.data)
    return dataPromise
  }
  static emailcheck(useremail){
    const promise = axios.get(`${url}check/${useremail}`,{
    })
    const dataPromise = promise.then((response) => response.data)
    return dataPromise
  }
  static verifyrole(useremail){
    const promise = axios.get(`${url}verifyrole/${useremail}`,{
    })
    const dataPromise = promise.then((response) => response.data)
    return dataPromise
  }
  static updateuserrole(email, code){
    const promise = axios.put(`${url}roleupdate/${email}/${code}`,{
    },{

    })
    const dataPromise = promise.then((response) => response.data)
    return dataPromise
  }
}




export default api