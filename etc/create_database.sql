CREATE DATABASE IF NOT EXISTS  `LAS2PEERMON`;
USE LAS2PEERMON;

CREATE TABLE IF NOT EXISTS `MESSAGE` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EVENT` varchar(255) NOT NULL,
  `TIME_STAMP` timestamp NOT NULL,
  `SOURCE_NODE` varchar(255) DEFAULT NULL,
  `SOURCE_AGENT` char(32) DEFAULT NULL,
  `DESTINATION_NODE` varchar(255) DEFAULT NULL,
  `DESTINATION_AGENT` char(32) DEFAULT NULL,
  `REMARKS` json DEFAULT NULL,
  `CASE_ID` varchar(63) DEFAULT NULL,
  `ACTIVITY_NAME` varchar(255) DEFAULT NULL,
  `RESOURCE` varchar(255) DEFAULT NULL,
  `RESOURCE_TYPE` varchar(255) DEFAULT NULL,
  `LIFECYCLE_PHASE` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`ID`)
);

  CREATE TABLE IF NOT EXISTS AGENT  
  (
    AGENT_ID CHAR(32) NOT NULL,
    TYPE ENUM("USER",
    "SERVICE",
    "GROUP",
    "MONITORING",
    "MEDIATOR"
  )
  ,
	CONSTRAINT AGENT_PK PRIMARY KEY
  (AGENT_ID)
);


  CREATE TABLE  IF NOT EXISTS  NODE
  (
    NODE_ID VARCHAR(255) NOT NULL,
    NODE_LOCATION VARCHAR(255) NOT NULL,
    CONSTRAINT NODE_PK PRIMARY KEY (NODE_ID)
  );


  CREATE TABLE  IF NOT EXISTS REGISTERED_AT
  (
    REGISTRATION_DATE TIMESTAMP NULL,
    UNREGISTRATION_DATE TIMESTAMP NULL,
    AGENT_ID CHAR(32) NOT NULL,
    RUNNING_AT VARCHAR(255),
    CONSTRAINT AGENT_ID_FK FOREIGN KEY (AGENT_ID) REFERENCES AGENT(AGENT_ID),
    CONSTRAINT RUNNING_AT_FK FOREIGN KEY (RUNNING_AT) REFERENCES NODE(NODE_ID)
  );


  CREATE TABLE  IF NOT EXISTS  SERVICE
  (
    AGENT_ID CHAR(32) NOT NULL,
    SERVICE_CLASS_NAME VARCHAR(255),
    SERVICE_PATH VARCHAR(255) NULL,
    CONSTRAINT SERVICE_PK PRIMARY KEY (AGENT_ID),
    CONSTRAINT SERVICE_FK FOREIGN KEY (AGENT_ID) REFERENCES AGENT(AGENT_ID),
    CONSTRAINT SERVICE_UK UNIQUE
    KEY
    (AGENT_ID,SERVICE_CLASS_NAME)
);

    CREATE TABLE IF NOT EXISTS GROUP_INFORMATION  
    (
      GROUP_AGENT_ID_MD5 CHAR(32) NOT NULL,
      GROUP_AGENT_ID CHAR(128) NOT NULL,
      GROUP_NAME VARCHAR(255) NOT NULL,
      PUBLIC BOOLEAN,
    CONSTRAINT GROUP_AGENT_ID_FK FOREIGN KEY
      (GROUP_AGENT_ID_MD5) REFERENCES AGENT
      (AGENT_ID)
);
