# QingDao University Online Judge

[open source code](https://github.com/QingdaoU/OnlineJudge)

### Connect Database
1. Reverse Proxy
- Stop the docker and add the following code into the **docker-compose.yml** file

```
ports:
      - "0.0.0.0:5400:5432"
```
![proxy](/assets/images/open-source-code-improvements/qduoj/database-proxy.png)

2. Connect Database
- Use software Navicat or other to connect PostgreSQL

```
database: onlinejudge
username: onlinejudge
password: onlinejudge
```
![database](/assets/images/open-source-code-improvements/qduoj/database-connect.png)
3. Check the Database

- Database info is showing as follow
![info](/assets/images/open-source-code-improvements/qduoj/database-info.png)

### Timed Task (Clone Database)
**Attention！！！There are some problems with the original database import and export code**
- U can see the host vm's time task in **time.py** & **db_backup.sh**
- U can see the spare vm's time task in **time_update.py** & **db_backup_update.sh**

The use steps are as follow:
1. First: Make sure that both the host vm and the spare vm start QDUOJ and the database structure is complete
2. Second: Make sure the vm has python3.6 (or higher version) installed
3. Third: Put **time.py** & **db_backup.sh** file in the same folder of host vm
4. Fourth: Put **time_update.py** & **db_backup_update.sh** file in the same folder of spare vm
5. Fifth: Run the **time.py** & **time_update.py** python files separately

### Https Mode
[official doc](http://opensource.qduoj.com/)

**Attention！！！There are some sentences in official doc that are not particularly easy to understood**

Some prerequisites:
- When OJ is created, it will automatically call the **service.cert** and **service.key** files in the data/backend/ssl/
- Before U use https mode, U'd better prepare a domain name, and bind the domain name to the IP

The use steps are as follow:
1. U can use the following code to create a local ssl cert & key

```
openssl genrsa -out tls.key 2048
openssl req -new -x509 -key tls.key -out tls.cert -days 360 -subj /CN=<your domain name>
```
2. Replace the built-in cert and key files
3. Use the following code to restart the nginx

```
docker exec -it oj-backend sh -c "cd /app/deploy; supervisorctl restart nginx"
```

- Attention!!! Please stop docker and turn on **'force https'** mode via change the **docker-compose.yml** file. By the way, the way to open **'force https'** mode is to uncomment the code **'FORCE_HTTPS=1'** in **docker-compose.yml** file. *If the certificate is complete, you can only uncomment the code.*

### Connect to your own database

Same as **'Connect Database'**, just add some code to **docker-compose.yml**

Add the following code to oj-postgres and oj-backend environment and change the POSTGRES_DB & USER & PASSWORD

```
 - POSTGRES_HOST=<your database host>
```

![own](/assets/images/open-source-code-improvements/qduoj/database-own.png)

### Browser Side

[open source code](https://github.com/QingdaoU/OnlineJudgeFE)

System: Ubuntu20.04

Nodejs:12.16.0

Npm:6.13.4


1. Install nodejs & docker first. And then using the following code.

```
# When performing npm install, there is an installation package that will cause npm install to fail due to permission issues.
npm install browserslist@^4.21.0 -g --no-bin-links

# During installation, it may not be possible to install because git cannot be connected. Please enable VPN or try again.
npm install

# If you meet error 'Error while executing /usr/bin ls-remote -h -t ssh://git@github.com/xxxx/xxxx.git', following:
git config --global url."https://github.com/".insteadOf git@github.com:
git config --global url."https://".insteadOf git://

# Official document standard process
export NODE_ENV=development
npm run build:dll
export TARGET=https://127.0.0.1
npm run dev
```


2. After modifying the code. Using the following code. After using the code, U will git a folder named dist

```
npm run build
```

3. mv the folder to OnlineJudgeDeploy/data/backend/dist, overwrite it!!!

4. Change the config file **"docker-compose.yml"**, add to **"oj-backend"** modules' **volumes**

```
- <path of dist>:/app/dist

example:
- ./data/backend/dist:/app/dist
```

5. Update the OJ system. (Maybe need to stop first?)

```
docker-compose up -d
```

### K8S Build

[K8S-QDUOJ](/cloud-native/build-ops/aks-qduoj)