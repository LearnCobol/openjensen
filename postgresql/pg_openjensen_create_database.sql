CREATE USER jensen ;
CREATE DATABASE openjensen WITH OWNER=jensen TEMPLATE=template0 ENCODING='UTF8' LC_COLLATE='sv_SE.utf8' LC_CTYPE='sv_SE.utf8'  ;
GRANT ALL PRIVILEGES ON DATABASE openjensen TO jensen ;
