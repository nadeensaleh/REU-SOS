

DROP TABLE IF EXISTS Posts;
DROP TABLE IF EXISTS Users;
DROP TABLE IF EXISTS Votes;
DROP TABLE IF EXISTS Topics;
DROP TABLE IF EXISTS Collections;
DROP TABLE IF EXISTS Collected_Posts;


CREATE TABLE Posts
(
	id int,
	created_at TIMESTAMP,
	name varchar(255),
	tagline varchar(1000),
	user_id int,
	user_username varchar(255),
	votes_count int, 
	comments_count int,
	redirect_url varchar(500),
	discussion_url varchar(500)
);

CREATE TABLE Users
(
	id int,
	created_at TIMESTAMP,
	name varchar(255),
	user_username varchar(255),
	headline varchar(1000),
	invited_by_id int,
	followers_count int,
	followings_count int,
	votes_count int,
	posts_count int,
	maker_of_count int,
	comments_count int
);

CREATE TABLE Votes
(
	id int,
	created_at TIMESTAMP,
	user_id int,
	post_id int,
	user_username varchar(255),
	post_name varchar(255),
	tagline varchar(1000),
	discussion_url varchar(500)
);

CREATE TABLE Topics
(
	id int,
	created_at TIMESTAMP,
	name varchar(255),
	tagline varchar(1000),
	followers_count int,
	posts_count int
);

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

CREATE TABLE Collected_Posts
(
	collection_id int,
	post_id int
);


LOAD DATA LOCAL INFILE 'data/posts.csv'
INTO TABLE Posts
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES -- Skip header
(id, created_at, name, tagline, user_id, user_username, votes_count, comments_count, redirect_url, discussion_url);
SHOW warnings;

LOAD DATA LOCAL INFILE 'data/users.csv'
INTO TABLE Users
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
    ESCAPED BY ''
LINES TERMINATED BY '\n'
IGNORE 1 LINES -- Skip header
(id, created_at, name, user_username, headline, invited_by_id, followers_count, followings_count, votes_count, posts_count, maker_of_count, comments_count);
SHOW warnings;

LOAD DATA LOCAL INFILE 'data/votes.csv'
INTO TABLE Votes
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES -- Skip header
(id, created_at, user_id, post_id, user_username, post_name, tagline, discussion_url);
SHOW warnings;

LOAD DATA LOCAL INFILE 'data/topics.csv'
INTO TABLE Topics
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES -- Skip header
(id, created_at, name, tagline, followers_count, posts_count);
SHOW warnings;

LOAD DATA LOCAL INFILE 'data/collections.csv'
INTO TABLE Collections
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES -- Skip header
(id, created_at, featured_at, name, tagline, subscriber_count, followers_count, user_id, user_username, posts_count);
SHOW warnings;

LOAD DATA LOCAL INFILE 'data/collected_posts.csv'
INTO TABLE Collected_Posts
CHARACTER SET utf8mb4
FIELDS TERMINATED BY ';'
    ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 LINES -- Skip header
(collection_id, post_id);
SHOW warnings;
