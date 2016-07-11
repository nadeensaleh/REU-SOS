create table posts_by_day ( day int, count int);
INSERT INTO posts_by_day SELECT DAYOFWEEK(created_at), COUNT(*) as timesCreated from posts GROUP BY DAYOFWEEK(created_at);
create table users_by_day ( day int, count int);
INSERT INTO users_by_day SELECT DAYOFWEEK(created_at), COUNT(*) as timesCreated from users GROUP BY DAYOFWEEK(created_at);
select * from posts_by_day;
 
select * from users_by_day;
select posts_count, maker_of_count, followers_count from users;
select posts_count, maker_of_count, followers_count from users ORDER BY followers_count DESC LIMIT 25;
select posts_count, maker_of_count, followers_count, votes_count from users ORDER BY followers_count DESC LIMIT 25;
select user_username,COUNT(*) as NumPosts from posts ORDER BY NumPosts DESC LIMIT 10;
select user_username,COUNT(*) as NumPosts from posts GROUP BY user_username ORDER BY NumPosts DESC LIMIT 10;
select tagline, votes_count from posts WHERE votes_count >= 38 Order By votes_count DESC LIMIT 40000;
select name,followers_count,posts_count from topics Order By followers_count DESC limit 10;

select name,followers_count,posts_count from topics Order By posts_count DESC limit 10;