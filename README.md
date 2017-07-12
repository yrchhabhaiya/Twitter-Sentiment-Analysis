# Twitter-Sentiment-Analysis
Twitter Sentiment Analysis through Flume and PIG.

Please follow Detailed Description.txt for detailed analysis of twitter data. Below is the summary on how we can collect and process the data in pig.

  1. Start the services.
	2. Create Twitter App and generate consumerKey, consumerSecretKey, accessToken & accessTokenSecret.
	3. Write Flume Config. (FlumeData collected is in Avro format.)
	4. Get the Avro schema from FlumeData and save it as AVSC file.
	5. Create Table in HIVE with the help of AVSC file.
	6. Create External Table HIVE and save it in HDFS location.
	7. Load data in PIG relation for further analysis.
