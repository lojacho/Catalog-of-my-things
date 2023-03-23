CREATE TABLE item (  
  id INT GENERATED ALWAYS AS IDENTITY,
  id_genre INT REFERENCES genre(id),
  id_author INT REFERENCES author(id),
  id_label INT REFERENCES label(id),
  publish_date DATE,
  archived BOOLEAN,
  PRIMARY KEY (id)
);


CREATE TABLE author (
  id INT GENERATED ALWAYS AS IDENTITY,
  first_name VARCHAR(250),
  last_name VARCHAR(250),
);


CREATE TABLE game (  
  id INT GENERATED ALWAYS AS IDENTITY,
  multiplayer BOOLEAN,
  last_played DATE,
  PRIMARY KEY (id)
);
/*---------------------------------------------------------*/


