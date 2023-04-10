# Dev Environment 

## Project Set-up 
1. Clone Repo 
  - ``` cd <Path-to-Repo> ```
2a. RUN ```docker-compose pull db ```  
2b. Run ```docker-compose up -d ```
3. While DB container is running copy over the dump.sql and run it (Only needs to be done when recreating volume)
  - Get the db docker container from docker desktop or ```docker ps``` and copy down the container id from the running db container
  - ``` docker cp ./db/databasetemplate.sql <dockercontainerid>:/dump.sql ```
  - ``` docker exec -it db psql -U postgres -f ./dump.sql ```
  - testing docker sql with 
  - ``` docker exec -it db psql -U postgres ```
  - to see all schemas: 
  ```SELECT schema_name FROM information_schema.schemata; ```
  - to see cron jobs 
  ``` SELECT * from cron.jobs ```
4. When working on the project and loading changes within your environment currently the process is:
  - Save changes to files 
  - Run ``` docker-compose up -d --build client --build api ```

## VPS 
- navigate to linehopperku.com
- Sign-up Using email (If using KU EDU email check security.microsoft.com and report as not phishing.)

## MISC 
On linux base if port for pg is bound:
- You can stop the process by finding the PID with ```lsof -i :5432```
- and then killing it with ```kill -9 <PID>```
