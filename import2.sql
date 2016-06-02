DROP TABLE IF EXISTS Topics;


CREATE TABLE Topics
(
	id int, 
	created_at TIMESTAMP, 
	name varchar(255), 
	tagline varchar(1000), 
	followers_count int,
	posts_count int
);




LOAD DATA LOCAL INFILE 'data/topics.csv' 
INTO TABLE Topics
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES -- Skip header
(id, created_at, name, tagline, followers_count, posts_count);
SHOW warnings;


DROP TABLE IF EXISTS Collections;


CREATE TABLE Collections
(
	id int, 
	created_at TIMESTAMP, 
	featured_at TIMESTAMP,
	name varchar(255), 
	tagline varchar(1000), 
	subscriber_count int,
	followers_count int,
	user_id int, 
	user_username varchar(255),
	posts_count int
);




LOAD DATA LOCAL INFILE 'data/collections.csv' 
INTO TABLE Collections
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES -- Skip header
(id, created_at, featured_at, name, tagline, subscriber_count, followers_count, user_id, user_username, posts_count);
SHOW warnings;

DROP TABLE IF EXISTS Collected_Posts;


CREATE TABLE Collected_Posts
(
	collection_id int,
	post_id int
);




LOAD DATA LOCAL INFILE 'data/collected_posts.csv' 
INTO TABLE Collected_Posts
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES -- Skip header
(collection_id, post_id);
SHOW warnings;




