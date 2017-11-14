START TRANSACTION;

CREATE TABLE MESSAGE_COPY (
	ID INT NOT NULL auto_increment,
	EVENT VARCHAR(255) NOT NULL,
	TIME_STAMP TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	SOURCE_NODE VARCHAR(255),
	SOURCE_AGENT CHAR(32),
	DESTINATION_NODE VARCHAR(255),
	DESTINATION_AGENT CHAR(32),
	REMARKS json DEFAULT NULL,
	CONSTRAINT MESSAGE_PK PRIMARY KEY (ID)
);

INSERT INTO MESSAGE_COPY
          (ID, EVENT, TIME_STAMP, SOURCE_NODE, SOURCE_AGENT, DESTINATION_NODE, DESTINATION_AGENT, REMARKS)
     (SELECT ID, EVENT, FROM_UNIXTIME(TIME_STAMP/1000), SOURCE_NODE, SOURCE_AGENT, DESTINATION_NODE, DESTINATION_AGENT, json_object('msg',REMARKS) FROM MESSAGE);

DROP TABLE IF EXISTS MESSAGE;

RENAME TABLE MESSAGE_COPY TO MESSAGE;

COMMIT;