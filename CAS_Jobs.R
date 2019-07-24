options(scipen = 999,digits=19) 
library(SciServer)
library(httr)
library(jsonlite)
library(utils)

# Define login Name and password before running these examples
Authentication_loginName = '';
Authentication_loginPassword = ''

Authentication_login_sharedWithName = ''
Authentication_login_sharedWithPassword = ''

# *******************************************************************************************************
# Authentication section
# *******************************************************************************************************

#?Authentication.login

#logging in and getting current token from different ways

token1 = Authentication.login(Authentication_loginName, Authentication_loginPassword);
token2 = Authentication.getToken()
token4 = Authentication.token
print(paste("token1=", token1))
print(paste("token2=", token2))
print(paste("token4=", token4))

#getting curent user info

user = Authentication.getKeystoneUserWithToken(token1)
print(paste("userName=", user$userName))
print(paste("id=", user$id))

#reseting the current token to another value:

Authentication.setToken("myToken1")
token5 = Authentication.getToken()
print(paste("token5=", token5))

#logging-in again

token1 = Authentication.login(Authentication_loginName, Authentication_loginPassword);
print(token1)

# *******************************************************************************************************
# Authentication section:
# *******************************************************************************************************

#?Authentication.login

#logging in and getting current token from different ways

token1 = Authentication.login(Authentication_loginName, Authentication_loginPassword);
token2 = Authentication.getToken()
print(paste("token1=", token1))
print(paste("token2=", token2))

#getting curent user info

user = Authentication.getKeystoneUserWithToken(token1)
print(paste("userName=", user$user))
print(paste("id=", user$id))
user

#reseting the current token to another value:

Authentication.setToken("myToken2")
token6 = Authentication.getToken()
print(paste("token6=", token6))

#logging-in again

token1 = Authentication.login(Authentication_loginName, Authentication_loginPassword);
print(token1)

# *******************************************************************************************************
# CasJobs section:
# *******************************************************************************************************


##"

#?CasJobs.executeQuery

#Defining databse context and query, and other variables

CasJobs_TestDatabase = "DR7"
CasJobs_TestQuery = 
  "SELECT
s.specObjID,
MAX(l.sigma * 300000.0 / l.wave) AS veldisp,
AVG(s.z) AS z INTO table_qso
FROM SpecObj s,
specLine l
WHERE s.specObjID = l.specObjID
AND (
(s.specClass = dbo.fSpecClass('QSO'))
OR (
s.specClass = dbo.fSpecClass('HIZ-QSO'))
AND s.z BETWEEN 2.1 AND 2.4
AND l.sigma * 300000.0 / l.wave > 2500.0
AND s.zConf > 0.9)
GROUP BY s.specObjID"
CasJ1sId = CasJobs.getSchemaName()
print(casJobsId)

#get info about tables inside MyDB database context:

tables = CasJobs.getTables(context="DR7")
print(tables)

#execute a quick SQL query:

df = CasJobs.executeQuery(sql=CasJobs_TestQuery, context=CasJobs_TestDatabase, format="dataframe")
print(df)

#submit a job, which inserts the query results into a table in the MyDB database context. 
#Wait until the job is done and get its status.

jobId = CasJobs.submitJob(sql=paste(CasJobs_TestQuery, " into MyDB.", CasJobs_TestTableName1, sep=""), context="DR7")
jobDescription = CasJobs.waitForJob(jobId=jobId, verbose=FALSE)
print(jobId)
print(jobDescription)


#execute a query and write a local Fits file containing the query results:

result = CasJobs.writeFitsFileFromQuery(fileName=CasJobs_TestFitsFile, queryString=CasJobs_TestQuery, context="DR7")
print(result)

