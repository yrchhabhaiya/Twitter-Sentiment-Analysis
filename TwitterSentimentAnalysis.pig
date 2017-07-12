A = LOAD '/user/externaltables/000000_0' USING AvroStorage('{"type":"record",
 "name":"Doc",
 "doc":"adoc",
 "fields":[{"name":"id","type":"string"},
           {"name":"user_friends_count","type":["int","null"]},
           {"name":"user_location","type":["string","null"]},
           {"name":"user_description","type":["string","null"]},
           {"name":"user_statuses_count","type":["int","null"]},
           {"name":"user_followers_count","type":["int","null"]},
           {"name":"user_name","type":["string","null"]},
           {"name":"user_screen_name","type":["string","null"]},
           {"name":"created_at","type":["string","null"]},
           {"name":"text","type":["string","null"]},
           {"name":"retweet_count","type":["long","null"]},
           {"name":"retweeted","type":["boolean","null"]},
           {"name":"in_reply_to_user_id","type":["long","null"]},
           {"name":"source","type":["string","null"]},
           {"name":"in_reply_to_status_id","type":["long","null"]},
           {"name":"media_url_https","type":["string","null"]},
           {"name":"expanded_url","type":["string","null"]}
          ]
}');

B = FILTER A BY (text matches '.* hate .*') OR (text matches '.* love .*');
C = FOREACH B GENERATE id, user_name, user_followers_count, text;
D = ORDER C BY user_followers_count DESC;

tokens = foreach D generate id,text, FLATTEN(TOKENIZE(text)) As word;

dictionary = LOAD '/user/acadgild/project/twitter/AFINN.txt' USING PigStorage('\t') AS(word:chararray,rating:int);

word_rating = JOIN tokens BY word LEFT OUTER, dictionary BY word USING 'replicated';

rating = foreach word_rating generate tokens::id as id,tokens::text as text, dictionary::rating as rate;

word_group = group rating by (id,text);

avg_rate = foreach word_group generate group, AVG(rating.rate) as tweet_rating;

positive_tweets = filter avg_rate by tweet_rating>=0;

negative_tweets = filter avg_rate by tweet_rating<0;

STORE positive_tweets into '/user/acadgild/project/twitter/positivetweets';

STORE negative_tweets into '/user/acadgild/project/twitter/negativetweets';

