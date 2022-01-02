DROP TABLE IF EXISTS feeding;
CREATE TABLE feeding (
     farmer INTEGER,
     animal INTEGER,
     PRIMARY KEY (farmer)
);
INSERT INTO feeding VALUES (2, 3);
SELECT * FROM feeding;