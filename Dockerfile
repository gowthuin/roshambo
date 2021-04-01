FROM tomcat:9.0

RUN cp -r webapps.dist/* webapps/

RUN apt-get update

RUN apt-get -y upgrade

RUN apt-get install -y default-jdk

RUN apt-get install -y maven

RUN export PATH=$PATH:$JAVA_HOME/bin

RUN apt-get -y install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg-agent \
    software-properties-common
    
RUN apt-get install -y maven

RUN apt-get install -y git

RUN git clone https://github.com/mhmtarik/roshambo.git

WORKDIR ./roshambo

RUN mvn compile

RUN mvn test 

RUN mvn clean package

RUN cp target/roshambo.war /usr/local/tomcat/webapps/

