CREATE TABLE movies (
movie_id int PRIMARY KEY,
movie_name nvarchar(50) NOT NULL,
director nvarchar(50) NOT NULL,
genre nvarchar(20) NOT NULL,
imdb_score int NOT NULL,
number_of_replays int NOT NULL,
persuasiveness int NOT NULL,
originality int NOT NULL,
impressiveness int NOT NULL,
cinematography int NOT NULL
);


INSERT INTO movies VALUES(1,'Amores Perros',' Alejandro González Iñárritu','Drama',8,2,8,6,7,5);
INSERT INTO movies VALUES(2,'Buffalo 66','Vincent Gallo','Comedy-Drama',7,4,8,8,9,8);
INSERT INTO movies VALUES(3,'Titanic','James Cameron','Drama',7,5,6,7,10,6);
INSERT INTO movies VALUES(4,'The Wind That Shakes the Barley',' Ken Loach','War-Drama',7,1,9,6,8,6);
INSERT INTO movies VALUES(5,'Requiem for a Dream','Darren Aronofsky','Drama-Psychological tension',8,4,8,8,10,10);
INSERT INTO movies VALUES(6,'Funny Games','Michael Haneke','Thriller',7,3,6,9,8,5);
INSERT INTO movies VALUES(7,'Lost Highway','David Lynch','Thriller',7,2,8,10,8,7);
INSERT INTO movies VALUES(8,'Memento','Christopher Nolan','Mystery',8,2,8,9,9,7);
INSERT INTO movies VALUES(9,'Mandariniid','Zaza Urushadze','Drama-War',8,1,10,7,8,7);
INSERT INTO movies VALUES(10,'Mulholland Dr.','David Lynch','Mystery',8,2,8,9,8,7);
INSERT INTO movies VALUES(11,'Pride and Prejudice','Joe Wright','Love',8,1,7,7,8,9);
INSERT INTO movies VALUES(12,'Atonement','Joe Wright','Romantic-Drama-War',8,2,9,8,10,8);
INSERT INTO movies VALUES(13,'Agora',' Alejandro Amenábar','Drama',7,2,10,7,10,8);
INSERT INTO movies VALUES(14,'The Hateful Eight','Quentin Tarantino','Western',8,1,7,8,8,9)
INSERT INTO movies VALUES(15,'The Good the Bad and the Ugly','Sergio Leone','Western',9,2,7,7,8,8);
INSERT INTO movies VALUES(16,'Shooting Dogs','Michael Caton-Jones','War-Drama',8,2,10,7,10,7);
INSERT INTO movies VALUES(17,'Incendies',' Denis Villeneuve','Drama',8,1,10,7,9,7);
INSERT INTO movies VALUES(18,'Lock Stock and Two Smoking Barrels','Guy Ritchie','Crime-Comedy',8,2,7,9,7,6);
INSERT INTO movies VALUES(19,'A Clockwork Orange','Stanley Kubrick','Crime-Drama',8,1,7,9,8,8);
INSERT INTO movies VALUES(20,'Donnie Darko',' Richard Kelly','Science Fiction',8,2,9,10,9,8);

/* First, calculate the averages of the criteria of the films one by one, and each film is awarded a score according to whether or not they are above average.*/

WITH movie_average AS  ( SELECT movie_name, CASE
WHEN imdb_score > (SELECT AVG(imdb_score) FROM movies) THEN 1 ELSE 0
END AS IMDB_SCORE,
CASE 
WHEN number_of_replays > (SELECT AVG(number_of_replays) FROM movies) THEN 1 ELSE 0
END AS NUMBER_OF_REPLAYS,
CASE
WHEN persuasiveness > (SELECT AVG(persuasiveness) FROM movies ) THEN 1 ELSE 0
END AS PERSUASIVENESS,
CASE
WHEN originality > (SELECT AVG(originality) FROM movies) THEN 1 ELSE 0
END AS ORIGINALITY,
CASE 
WHEN impressiveness > (SELECT AVG(impressiveness) FROM movies) THEN 1 ELSE 0
END AS IMPRESSIVENESS,
CASE
WHEN cinematography > (SELECT AVG(cinematography) FROM movies) THEN 1 ELSE 0
END AS CINEMATOGRAPHY

FROM movies)


/* Second, add the scores of each movie, rank the score and get the top 5 */

SELECT TOP(5) movie_name, SUM(IMDB_SCORE + NUMBER_OF_REPLAYS + PERSUASIVENESS + ORIGINALITY+ IMPRESSIVENESS + CINEMATOGRAPHY) AS movie_rate
FROM movie_average
GROUP BY movie_name
ORDER BY movie_rate DESC ;



