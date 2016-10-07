##What is ProductHunt?
Founded in 2013, ProductHunt is a website that lets users share and discover new products. According to The Verge and Business Insider, ProductHunt


##Main Questions
* How do posts correlate to day of the week?
	- sql query
	- Heat map
* Does posting more correlate to more followers? <- did not find a relationship
	- Do a t-test in R
* Did posts get upvoted when the collection was featured?


##Tools, process and errors
1. Tried visualizing in GraphLab
2. **Error alert!** Realized data we unorganzied so we uploaded our data to a SQL database and queried to find the relation between day of the week and posts.
 
   `create table posts_by_day(dat int, count int);`
   
   `insert into posts_by_day select DAYOFWEEK(created_at) as day, count(*) as count from posts group by day;`
   
3. We noticed a lot of NULL columns. That's when we realized the headers were changed.. time to reimport the import.sql file with the correct headers (some were ommited in the new dataset, e.j. profile_url, image)
4. Took all instances of taglines over the median post value (38) and analyzed the text to extract the most popular phrases/words.
