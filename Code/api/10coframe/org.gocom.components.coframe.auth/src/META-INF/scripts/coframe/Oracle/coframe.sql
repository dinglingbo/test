DROP TABLE CAP_PARTYAUTH CASCADE CONSTRAINTS;
DROP TABLE CAP_RESAUTH CASCADE CONSTRAINTS;
DROP TABLE CAP_ROLE CASCADE CONSTRAINTS;
DROP TABLE COMP_IP_ACCESS_RULES CASCADE CONSTRAINTS;
DROP TABLE COMP_WIN7_AUTO_START CASCADE CONSTRAINTS;
DROP TABLE COMP_WIN7_CONFIG CASCADE CONSTRAINTS;
DROP TABLE COMP_WIN7_CUSTOM_PICTURES CASCADE CONSTRAINTS;
DROP TABLE COMP_WIN7_ICONS CASCADE CONSTRAINTS;
DROP TABLE APP_FUNCRESOURCE CASCADE CONSTRAINTS;
DROP TABLE APP_FUNCTION CASCADE CONSTRAINTS;
DROP TABLE APP_FUNCGROUP CASCADE CONSTRAINTS;
DROP TABLE APP_APPLICATION CASCADE CONSTRAINTS;
DROP TABLE APP_MENU CASCADE CONSTRAINTS;
DROP TABLE CAP_SSOUSER CASCADE CONSTRAINTS;
DROP TABLE CAP_USER CASCADE CONSTRAINTS;
DROP TABLE ORG_EMPORG CASCADE CONSTRAINTS;
DROP TABLE ORG_EMPPOSITION CASCADE CONSTRAINTS;
DROP TABLE ORG_EMPGROUP CASCADE CONSTRAINTS;
DROP TABLE ORG_EMPLOYEE CASCADE CONSTRAINTS;
DROP TABLE ORG_GROUP CASCADE CONSTRAINTS;
DROP TABLE ORG_GROUPPOSI CASCADE CONSTRAINTS;
DROP TABLE ORG_POSITION CASCADE CONSTRAINTS;
DROP TABLE ORG_DUTY CASCADE CONSTRAINTS;
DROP TABLE ORG_ORGANIZATION CASCADE CONSTRAINTS;
DROP TABLE ORG_RECENT_VISIT CASCADE CONSTRAINTS;


CREATE TABLE CAP_RESAUTH (
	PARTY_ID VARCHAR2(64) NOT NULL,
	PARTY_TYPE VARCHAR2(64) NOT NULL,
	RES_ID VARCHAR2(255) NOT NULL,
	RES_TYPE VARCHAR2(64) NOT NULL,
	TENANT_ID VARCHAR2(64),
	RES_STATE VARCHAR2(512) NOT NULL,
	PARTY_SCOPE VARCHAR2(1) DEFAULT '0',
	CREATEUSER VARCHAR2(64),
	CREATETIME TIMESTAMP,
	PRIMARY KEY (PARTY_ID,PARTY_TYPE,RES_ID,RES_TYPE)); 
CREATE TABLE CAP_ROLE (
	ROLE_ID VARCHAR2(64) NOT NULL,
	TENANT_ID VARCHAR2(64) NOT NULL,
	ROLE_CODE VARCHAR2(64) NOT NULL,
	ROLE_NAME VARCHAR2(64),
	ROLE_DESC VARCHAR2(255),
	CREATEUSER VARCHAR2(64),
	CREATETIME TIMESTAMP,
	PRIMARY KEY (ROLE_ID)); 
CREATE TABLE COMP_IP_ACCESS_RULES (
	RULES_ID VARCHAR2(255) NOT NULL,
	START_IP VARCHAR2(255),
	END_IP VARCHAR2(255),
	RULES_TYPE VARCHAR2(255),
	REMARK VARCHAR2(255),
	MAKERS_ID VARCHAR2(255),
	ADD_DATE VARCHAR2(255),
	ENABLED VARCHAR2(255),
	PRIMARY KEY (RULES_ID)); 
CREATE TABLE COMP_WIN7_AUTO_START (
	START_ID VARCHAR2(255) NOT NULL,
	MENU_ID VARCHAR2(255),
	START_DESC VARCHAR2(255),
	USER_ID VARCHAR2(255),
	PRIMARY KEY (START_ID)); 
CREATE TABLE COMP_WIN7_CONFIG (
	CONFIG_ID VARCHAR2(255) NOT NULL,
	BG_PICTURE_PATH VARCHAR2(255),
	USER_ID VARCHAR2(255),
	CONFIG_DATA CLOB,
	OPEN_TYPE VARCHAR2(255),
	DEFAULT_MAX NUMBER(1,0),
	DEFAULT_WIDTH NUMBER(10,0),
	DEFAULT_HEIGHT NUMBER(10,0),
	DESK_STYLE VARCHAR2(255),
	EXT1 VARCHAR2(255),
	EXT2 VARCHAR2(255),
	EXT3 VARCHAR2(255),
	PRIMARY KEY (CONFIG_ID)); 
CREATE TABLE COMP_WIN7_CUSTOM_PICTURES (
	CUSTOM_ID VARCHAR2(255) NOT NULL,
	FILE_NAME VARCHAR2(255),
	USER_ID VARCHAR2(255),
	UPLOAD_TIME VARCHAR2(255),
	PRIMARY KEY (CUSTOM_ID)); 
CREATE TABLE COMP_WIN7_ICONS (
	ICON_ID VARCHAR2(255) NOT NULL,
	ICON_NAME VARCHAR2(255),
	ICON_TEXT VARCHAR2(255),
	ICON_PATH VARCHAR2(255),
	ICON_TITLE VARCHAR2(255),
	MENU_ID VARCHAR2(255),
	ICON_INDEX VARCHAR2(255),
	ICON_DESC VARCHAR2(255),
	USER_ID VARCHAR2(255),
	PRIMARY KEY (ICON_ID)); 
CREATE TABLE APP_APPLICATION (
	APPID NUMBER(10,0) NOT NULL,
	APPCODE VARCHAR2(32),
	APPNAME VARCHAR2(50),
	APPTYPE VARCHAR2(255),
	ISOPEN VARCHAR2(1),
	OPENDATE DATE,
	URL VARCHAR2(256),
	APPDESC VARCHAR2(512),
	MAINTENANCE NUMBER(10,0),
	MANAROLE VARCHAR2(64),
	DEMO VARCHAR2(512),
	INIWP VARCHAR2(1),
	INTASKCENTER VARCHAR2(1),
	IPADDR VARCHAR2(50),
	IPPORT VARCHAR2(10),
	APP_ID VARCHAR2(64),
	TENANT_ID VARCHAR2(64) NOT NULL,
	PROTOCOL_TYPE VARCHAR2(64),
	PRIMARY KEY (APPID)); 
CREATE TABLE APP_FUNCGROUP (
	FUNCGROUPID NUMBER(10,0) NOT NULL,
	FUNCGROUPNAME VARCHAR2(40),
	GROUPLEVEL NUMBER(10,0),
	FUNCGROUPSEQ VARCHAR2(256),
	ISLEAF VARCHAR2(1),
	SUBCOUNT NUMBER(10,0),
	APP_ID VARCHAR2(64),
	TENANT_ID VARCHAR2(64) NOT NULL,
	PARENTGROUP NUMBER(10,0),
	APPID NUMBER(10,0) NOT NULL,
	PRIMARY KEY (FUNCGROUPID)); 
CREATE TABLE APP_FUNCRESOURCE (
	RESID NUMBER(10,0) NOT NULL,
	RESTYPE VARCHAR2(255),
	RESPATH VARCHAR2(256),
	COMPACKNAME VARCHAR2(40),
	RESNAME VARCHAR2(40),
	APP_ID VARCHAR2(64),
	TENANT_ID VARCHAR2(64) NOT NULL,
	FUNCCODE VARCHAR2(255),
	PRIMARY KEY (RESID)); 
CREATE TABLE APP_FUNCTION (
	FUNCCODE VARCHAR2(255) NOT NULL,
	FUNCNAME VARCHAR2(128) NOT NULL,
	FUNCDESC VARCHAR2(512),
	FUNCACTION VARCHAR2(256),
	PARAINFO VARCHAR2(256),
	ISCHECK VARCHAR2(1),
	FUNCTYPE VARCHAR2(255) DEFAULT '1',
	ISMENU VARCHAR2(1),
	APP_ID VARCHAR2(64),
	TENANT_ID VARCHAR2(64) NOT NULL,
	FUNCGROUPID NUMBER(10,0),
	PRIMARY KEY (FUNCCODE)); 
CREATE TABLE APP_MENU (
	MENUID VARCHAR2(40) NOT NULL,
	MENUNAME VARCHAR2(40) NOT NULL,
	MENULABEL VARCHAR2(40) NOT NULL,
	MENUCODE VARCHAR2(40),
	ISLEAF VARCHAR2(1),
	PARAMETER VARCHAR2(256),
	UIENTRY VARCHAR2(256),
	MENULEVEL NUMBER(5,0),
	ROOTID VARCHAR2(40),
	DISPLAYORDER NUMBER(5,0),
	IMAGEPATH VARCHAR2(100),
	EXPANDPATH VARCHAR2(100),
	MENUSEQ VARCHAR2(256),
	OPENMODE VARCHAR2(255),
	SUBCOUNT NUMBER(10,0),
	APPID NUMBER(10,0),
	FUNCCODE VARCHAR2(255),
	APP_ID VARCHAR2(64),
	TENANT_ID VARCHAR2(64) NOT NULL,
	PARENTSID VARCHAR2(40),
	PRIMARY KEY (MENUID)); 
CREATE TABLE CAP_PARTYAUTH (
	ROLE_TYPE VARCHAR2(64) NOT NULL,
	PARTY_ID VARCHAR2(64) NOT NULL,
	PARTY_TYPE VARCHAR2(64) NOT NULL,
	ROLE_ID VARCHAR2(64) NOT NULL,
	TENANT_ID VARCHAR2(64) NOT NULL,
	CREATEUSER VARCHAR2(64),
	CREATETIME TIMESTAMP NOT NULL,
	PRIMARY KEY (ROLE_TYPE,PARTY_ID,PARTY_TYPE,ROLE_ID)); 
CREATE TABLE CAP_SSOUSER (
	OPERATOR_ID VARCHAR2(64) NOT NULL,
	TENANT_ID VARCHAR2(64),
	USER_ID VARCHAR2(64) NOT NULL,
	PASSWORD VARCHAR2(100),
	USER_NAME VARCHAR2(64),
	EMAIL VARCHAR2(128),
	STATUS VARCHAR2(16),
	UNLOCKTIME TIMESTAMP,
	LASTLOGIN TIMESTAMP NOT NULL,
	ERRCOUNT NUMBER(10,0),
	MACCODE VARCHAR2(255),
	IPADDRESS VARCHAR2(255),
	CREATEUSER VARCHAR2(64),
	CREATETIME TIMESTAMP NOT NULL,
	PRIMARY KEY (OPERATOR_ID)); 
CREATE TABLE CAP_USER (
	OPERATOR_ID NUMBER(18,0) NOT NULL,
	TENANT_ID VARCHAR2(64) NOT NULL,
	USER_ID VARCHAR2(64) NOT NULL,
	PASSWORD VARCHAR2(100),
	INVALDATE DATE,
	USER_NAME VARCHAR2(64),
	AUTHMODE VARCHAR2(255),
	STATUS VARCHAR2(16),
	UNLOCKTIME TIMESTAMP NOT NULL,
	MENUTYPE VARCHAR2(255),
	LASTLOGIN TIMESTAMP NOT NULL,
	ERRCOUNT NUMBER(10,0),
	STARTDATE DATE,
	ENDDATE DATE,
	VALIDTIME VARCHAR2(255),
	MACCODE VARCHAR2(128),
	IPADDRESS VARCHAR2(128),
	EMAIL VARCHAR2(255),
	CREATEUSER VARCHAR2(64),
	CREATETIME TIMESTAMP NOT NULL,
	PRIMARY KEY (OPERATOR_ID)); 
CREATE TABLE ORG_DUTY (
	DUTYID NUMBER(10,0) NOT NULL,
	DUTYCODE VARCHAR2(20),
	DUTYNAME VARCHAR2(30),
	PARENTDUTY NUMBER(10,0),
	DUTYLEVEL NUMBER(10,0),
	DUTYSEQ VARCHAR2(256),
	DUTYTYPE VARCHAR2(255),
	ISLEAF VARCHAR2(10),
	SUBCOUNT NUMBER(10,0),
	REMARK VARCHAR2(256),
	TENANT_ID VARCHAR2(64) NOT NULL,
	APP_ID VARCHAR2(64),
	PRIMARY KEY (DUTYID)); 
CREATE TABLE ORG_EMPGROUP (
	GROUPID NUMBER(10,0) NOT NULL,
	EMPID NUMBER(10,0) NOT NULL,
	ISMAIN VARCHAR2(1),
	TENANT_ID VARCHAR2(64) NOT NULL,
	APP_ID VARCHAR2(64),
	PRIMARY KEY (GROUPID,EMPID)); 
CREATE TABLE ORG_EMPLOYEE (
	EMPID NUMBER(10,0) NOT NULL,
	EMPCODE VARCHAR2(30),
	OPERATORID NUMBER(18,0),
	USERID VARCHAR2(30),
	EMPNAME VARCHAR2(50),
	REALNAME VARCHAR2(50),
	GENDER VARCHAR2(255),
	BIRTHDATE DATE,
	POSITION NUMBER(10,0),
	EMPSTATUS VARCHAR2(255),
	CARDTYPE VARCHAR2(255),
	CARDNO VARCHAR2(20),
	INDATE DATE,
	OUTDATE DATE,
	OTEL VARCHAR2(12),
	OADDRESS VARCHAR2(255),
	OZIPCODE VARCHAR2(10),
	OEMAIL VARCHAR2(128),
	FAXNO VARCHAR2(14),
	MOBILENO VARCHAR2(14),
	QQ VARCHAR2(16),
	HTEL VARCHAR2(12),
	HADDRESS VARCHAR2(128),
	HZIPCODE VARCHAR2(10),
	PEMAIL VARCHAR2(128),
	PARTY VARCHAR2(255),
	DEGREE VARCHAR2(255),
	SORTNO NUMBER(10,0),
	MAJOR NUMBER(10,0),
	SPECIALTY VARCHAR2(1024),
	WORKEXP VARCHAR2(512),
	REGDATE DATE,
	CREATETIME DATE NOT NULL,
	LASTMODYTIME DATE NOT NULL,
	ORGIDLIST VARCHAR2(128),
	ORGID NUMBER(10,0),
	REMARK VARCHAR2(512),
	TENANT_ID VARCHAR2(64) NOT NULL,
	APP_ID VARCHAR2(64),
	WEIBO VARCHAR2(255),
	PRIMARY KEY (EMPID)); 
CREATE TABLE ORG_EMPORG (
	ORGID NUMBER(10,0) NOT NULL,
	EMPID NUMBER(10,0) NOT NULL,
	ISMAIN VARCHAR2(1),
	TENANT_ID VARCHAR2(64) NOT NULL,
	APP_ID VARCHAR2(64),
	PRIMARY KEY (ORGID,	EMPID)); 
CREATE TABLE ORG_EMPPOSITION (
	POSITIONID NUMBER(10,0) NOT NULL,
	EMPID NUMBER(10,0) NOT NULL,
	ISMAIN VARCHAR2(1),
	TENANT_ID VARCHAR2(64) NOT NULL,
	APP_ID VARCHAR2(64),
	PRIMARY KEY (POSITIONID,EMPID)); 
CREATE TABLE ORG_GROUP (
	GROUPID NUMBER(10,0) NOT NULL,
	ORGID NUMBER(10,0),
	GROUPLEVEL NUMBER(10,0),
	GROUPNAME VARCHAR2(50),
	GROUPDESC VARCHAR2(512),
	GROUPTYPE VARCHAR2(255),
	GROUPSEQ VARCHAR2(256),
	STARTDATE DATE,
	ENDDATE DATE,
	GROUPSTATUS VARCHAR2(255),
	MANAGER VARCHAR2(30),
	CREATETIME TIMESTAMP NOT NULL,
	LASTUPDATE DATE,
	UPDATOR NUMBER(10,0),
	ISLEAF VARCHAR2(1),
	SUBCOUNT NUMBER(10,0),
	TENANT_ID VARCHAR2(64) NOT NULL,
	APP_ID VARCHAR2(64),
	PARENTGROUPID NUMBER(10,0),
	PRIMARY KEY (GROUPID)); 
CREATE TABLE ORG_GROUPPOSI (
	GROUPID NUMBER(10,0) NOT NULL,
	POSITIONID NUMBER(10,0) NOT NULL,
	ISMAIN VARCHAR2(1),
	TENANT_ID VARCHAR2(64) NOT NULL,
	APP_ID VARCHAR2(64),
	PRIMARY KEY (GROUPID,POSITIONID)); 
CREATE TABLE ORG_ORGANIZATION (
	ORGID NUMBER(10,0) NOT NULL,
	ORGCODE VARCHAR2(32) NOT NULL,
	ORGNAME VARCHAR2(64),
	ORGLEVEL NUMBER(2,0) DEFAULT 1,
	ORGDEGREE VARCHAR2(255),
	ORGSEQ VARCHAR2(512),
	ORGTYPE VARCHAR2(12),
	ORGADDR VARCHAR2(256),
	ZIPCODE VARCHAR2(10),
	MANAPOSITION NUMBER(10,0),
	MANAGERID NUMBER(10,0),
	ORGMANAGER VARCHAR2(128),
	LINKMAN VARCHAR2(30),
	LINKTEL VARCHAR2(20),
	EMAIL VARCHAR2(128),
	WEBURL VARCHAR2(512),
	STARTDATE DATE,
	ENDDATE DATE,
	STATUS VARCHAR2(255),
	AREA VARCHAR2(30),
	CREATETIME TIMESTAMP NOT NULL,
	LASTUPDATE TIMESTAMP NOT NULL,
	UPDATOR NUMBER(10,0),
	SORTNO NUMBER(10,0),
	ISLEAF VARCHAR2(1),
	SUBCOUNT NUMBER(10,0),
	REMARK VARCHAR2(512),
	TENANT_ID VARCHAR2(64) NOT NULL,
	APP_ID VARCHAR2(64),
	PARENTORGID NUMBER(10,0),
	PRIMARY KEY (ORGID)); 
CREATE TABLE ORG_POSITION (
	POSITIONID NUMBER(10,0) NOT NULL,
	POSICODE VARCHAR2(20),
	POSINAME VARCHAR2(128) NOT NULL,
	POSILEVEL NUMBER(2,0),
	POSITIONSEQ VARCHAR2(512) NOT NULL,
	POSITYPE VARCHAR2(255),
	CREATETIME DATE NOT NULL,
	LASTUPDATE DATE NOT NULL,
	UPDATOR NUMBER(10,0),
	STARTDATE DATE,
	ENDDATE DATE,
	STATUS VARCHAR2(255),
	ISLEAF VARCHAR2(1),
	SUBCOUNT NUMBER(10,0),
	TENANT_ID VARCHAR2(64) NOT NULL,
	APP_ID VARCHAR2(64),
	DUTYID NUMBER(10,0),
	MANAPOSI NUMBER(10,0),
	ORGID NUMBER(10,0),
	PRIMARY KEY (POSITIONID)); 
CREATE TABLE ORG_RECENT_VISIT (
	ID VARCHAR2(32) NOT NULL,
	TARGET_ID VARCHAR2(32) NOT NULL,
	USERID VARCHAR2(32) NOT NULL,
	FREQUENCY NUMBER(10,0) DEFAULT 1 NOT NULL,
	LASTTIME TIMESTAMP NOT NULL,
	TARGET_TYPE VARCHAR2(32) NOT NULL,
	PRIMARY KEY (ID)); 

/*==============================================================*/
/* TABLE: CAP_RULEAUTH                                          */
/*==============================================================*/
DROP TABLE CAP_RULEAUTH CASCADE CONSTRAINTS;
CREATE TABLE CAP_RULEAUTH  (
   RULEAUTH_ID          VARCHAR2(64)                    NOT NULL,
   TENANT_ID            VARCHAR2(64)                    NOT NULL,
   RULE_ID              VARCHAR2(64)                    NOT NULL,
   RES_ID               VARCHAR2(255)                   NOT NULL,
   RES_TYPE             VARCHAR2(64)                    NOT NULL,
   RES_STATE            VARCHAR2(512)                   NOT NULL,
   CREATEUSER           VARCHAR2(64),
   CREATETIME           TIMESTAMP,
   PRIMARY KEY (RULEAUTH_ID)
);
CREATE INDEX IDX_CAP_RULEAUTH_RULE_ID ON CAP_RULEAUTH(RULE_ID);

DROP TABLE CAP_RULE CASCADE CONSTRAINTS;
CREATE TABLE CAP_RULE (
	RULE_ID VARCHAR2(64) DEFAULT '' NOT NULL,
	RULE_NAME VARCHAR2(64) DEFAULT '' NOT NULL,
	TENANT_ID VARCHAR2(64) DEFAULT '' NOT NULL,
	RULE_TYPE VARCHAR2(64) DEFAULT '' NOT NULL,
	NAMESPACE VARCHAR2(512) DEFAULT '' NOT NULL,
	RULE_EXPRESSION BLOB,
	CREATEUSER VARCHAR2(64),
	CREATETIME DATE,
	PRIMARY KEY (RULE_ID)); 