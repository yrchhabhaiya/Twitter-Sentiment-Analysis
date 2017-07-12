CREATE TABLE tweets
  ROW FORMAT SERDE
     'org.apache.hadoop.hive.serde2.avro.AvroSerDe'
  STORED AS INPUTFORMAT
     'org.apache.hadoop.hive.ql.io.avro.AvroContainerInputFormat'
  OUTPUTFORMAT
     'org.apache.hadoop.hive.ql.io.avro.AvroContainerOutputFormat'
  TBLPROPERTIES ('avro.schema.url'='file:///home/acadgild/project/TwitterDataAvroSchema.avsc') ;

DESCRIBE tweets;

LOAD DATA INPATH '/user/flume/tweets/FlumeData.1499696802953' OVERWRITE INTO TABLE tweets;

