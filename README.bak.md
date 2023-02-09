# LineHopper
CSC354/355 Team Project. 


## Commands
YOU WILL NEED TO MATCH THE DB INFO IN Server/queries.js to match your log in. 

### RUN THESE IN ORDER
```
cd <main LineHopper Folder>
npm install 
cd ./client 
npm install 
cd ..

```
### Node (Backend / Api)
```
npm start
```
### Client (frontend)
```
npm run client
```
### Postgresql 
```
Install psql 15.1 
create db under postgres user 
Update /Server/queries.js 
to user proper personal login and admin 

const pool = new Pool({
    //Configs    
    user: 'postgres',
    host: 'localhost',
    database: '', // place db name here
    password: '', // place default postgres Acc password here
    port: 5432
})


Good Luck
```
