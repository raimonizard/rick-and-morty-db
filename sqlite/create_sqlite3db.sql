sqlite3 ricky_morty.db

-- CREATE TABLES
CREATE TABLE landing_table (	id SMALLINT UNSIGNED NOT NULL
   , season_num TINYINT UNSIGNED
   , episode_num TINYINT UNSIGNED
   , episode_name CHAR(255)
   , character_name CHAR(255)
   , line TEXT
   , CONSTRAINT pk_phrases PRIMARY KEY (id)
);

CREATE TABLE episode(
    episode_id INTEGER PRIMARY KEY,
    episode_name CHAR(255)
);

CREATE TABLE character(
    character_id INTEGER PRIMARY KEY,
    character_name CHAR(255)
);

CREATE TABLE phrases(
    phrases_id INTEGER PRIMARY KEY,
    season_num INTEGER,
    episode_id INTEGER,
    character_id INTEGER,
    line TEXT,
    CONSTRAINT fk_phrases_episode FOREIGN KEY (episode_id) REFERENCES episode(id),
    CONSTRAINT fk_phrases_character FOREIGN KEY (character_id) REFERENCES character(id)
);

.tables
.schema landing_table

-- LOAD CSV
.mode csv
.import ../datafiles/ricky_morty_phrases.csv landing_table

SELECT * FROM landing_table;

-- INSERT INTO FINAL TABLES
INSERT INTO character(character_name)
    SELECT DISTINCT character_name FROM landing_table ORDER BY 1 ASC;

INSERT INTO episode(episode_name) SELECT distinct episode_name FROM landing_table ORDER BY episode_num ASC;

INSERT INTO phrases(season_num,episode_id,character_id,line)
    SELECT DISTINCT lt.season_num, ep.episode_id, ch.character_id, lt.line                                             
    FROM landing_table lt, episode ep, character ch
    WHERE lt.episode_name = ep.episode_name
        AND lt.character_name = ch.character_name
    ORDER BY 1,2,3;