FROM tomcat

RUN addgroup tomcatusers && adduser --disabled-password tomcat && adduser tomcat tomcatusers
RUN chown -R tomcat:tomcatusers .
USER tomcat

COPY editor.war /usr/local/tomcat/webapps/editor.war
COPY index.jsp /usr/local/tomcat/webapps/ROOT/index.jsp

