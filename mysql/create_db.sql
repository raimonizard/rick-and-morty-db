CREATE DATABASE IF NOT EXISTS rickymorty
CHARACTER SET 'utf8mb4'
COLLATE 'utf8mb4_general_ci'
;

USE rickymorty;

DROP TABLE IF EXISTS phrases;

CREATE TABLE IF NOT EXISTS phrases(
	id SMALLINT UNSIGNED NOT NULL
   , season_num TINYINT UNSIGNED
   , episode_num TINYINT UNSIGNED
   , episode_name CHAR(255)
   , character_name CHAR(255)
   , line TEXT
   , CONSTRAINT pk_phrases PRIMARY KEY (id)
);


select *
from phrases;

delete from phrases;

select @@datadir;

LOAD DATA INFILE '../datafiles/RickAndMortyScripts.csv'
INTO TABLE phrases
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\r\n'
IGNORE 1 LINES;

CREATE OR REPLACE VIEW frases_morty AS
	SELECT line
	FROM phrases
	WHERE character_name = 'Morty';
    
SELECT *
FROM frases_morty;

select id, count(1)
from phrases
group by id
having count(1)> 1;
