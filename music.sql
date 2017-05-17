CREATE TABLE Artist (
   id SERIAL NOT null PRIMARY KEY,
   name VARCHAR
);

CREATE TABLE Album (
   id SERIAL NOT null PRIMARY KEY,
   title VARCHAR,
   year SMALLINT
);

CREATE TABLE Song (
  id SERIAL NOT null PRIMARY KEY,
  name VARCHAR,
  duration TIME
);

CREATE TABLE Writer (
  id SERIAL NOT null PRIMARY KEY,
  name VARCHAR
);

CREATE TABLE Track (
   album_id INTEGER REFERENCES album(id),
   song_id INTEGER REFERENCES song(id),
   artist_id INTEGER REFERENCES artist(id)
);

CREATE TABLE SongWriters (
  song_id INTEGER REFERENCES song(id),
  writer_id INTEGER REFERENCES writer(id)
)
