-- Questions
--
-- You will answer the following questions by writing SQL queries:
--
-- What are tracks for a given album?
SELECT s.name, a.title
FROM Song s
JOIN Track t
ON s.id = t.song_id
JOIN Album a
ON a.id = t.album_id;

-- What are the albums produced by a given artist?
SELECT DISTINCT(r.name), a.title
FROM Artist r
JOIN Track t
ON r.id = t.artist_id
JOIN Album a
ON a.id = t.album_id
ORDER BY r.name;

-- What is the track with the longest duration?
SELECT name, duration
FROM Song
WHERE duration = (SELECT MAX(duration) FROM Song);

-- What are the albums released in the 60s? 70s? 80s? 90s?
SELECT title, year
FROM Album
WHERE year::text LIKE '196_';
-- Change 3rd digit for 70s, 80s, 90s

-- How many albums did a given artist produce in the 90s?
SELECT name, COUNT(name) "Album Count"
FROM (SELECT DISTINCT(a.title), name
FROM Album a
JOIN Track t
ON a.id = t.album_id
JOIN Artist r
ON r.id = t.artist_id
WHERE year::text LIKE '199_'
GROUP BY title, name) AS ra
GROUP BY name;

-- What is each artist's latest album?
SELECT name, title "Latest Album", MAX(year) year
FROM Artist r
JOIN Track t
ON r.id = t.artist_id
JOIN Album a
ON a.id = t.album_id
GROUP BY name, title;

-- List all albums along with its total duration based on summing the duration of its tracks.
SELECT title, SUM(duration)
FROM (SELECT *
FROM Album a
JOIN Track t
ON a.id = t.album_id
JOIN Song s
ON s.id = t.song_id) AS AlbumSongs
GROUP BY title;

-- What is the album with the longest duration?
SELECT MAX(album_length) "Album Length"
FROM (SELECT title, SUM(duration) album_length
FROM (SELECT *
FROM Album a
JOIN Track t
ON a.id = t.album_id
JOIN Song s
ON s.id = t.song_id) AS AlbumSongs
GROUP BY title) AS AlbumLengths;

-- Who are the 5 most prolific artists based on the number of albums they have recorded?

-- What are all the tracks a given artist has recorded?

-- What are the top 5 most often recorded songs?

-- Who are the top 5 song writers whose songs have been most often recorded?

-- Who is the most prolific song writer based on the number of songs he has written?

-- What songs has a given artist recorded?

-- Who are the song writers whose songs a given artist has recorded?

-- Who are the artists who have recorded a given song writer's songs?
