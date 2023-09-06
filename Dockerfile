# Use a base image with the necessary environment for Scala applications
FROM openjdk:11

# Set the working directory inside the container
WORKDIR /app

# Install sbt
RUN curl -L "https://github.com/sbt/sbt/releases/download/v1.5.5/sbt-1.5.5.tgz" -o sbt-1.5.5.tgz && \
    tar -xvf sbt-1.5.5.tgz && \
    rm sbt-1.5.5.tgz && \
    mv sbt /usr/local && \
    ln -s /usr/local/sbt/bin/sbt /usr/local/bin/sbt

# Copy the necessary files to the container
COPY . /app

ENV JAVA_OPTS="-Dotel.java.global-autoconfigure.enabled=true"

# Add Log4j dependencies
RUN sbt "set libraryDependencies += \"org.apache.logging.log4j\" % \"log4j-api\" % \"2.20.0\""
RUN sbt "set libraryDependencies += \"org.apache.logging.log4j\" % \"log4j-core\" % \"2.20.0\""
RUN sbt "set libraryDependencies += \"org.apache.logging.log4j\" % \"log4j-slf4j-impl\" % \"2.20.0\""
RUN sbt "set libraryDependencies += \"com.typesafe.akka\" %% \"akka-actor\" % \"2.8.0\""
RUN sbt "set libraryDependencies += \"io.opentelemetry\" % \"opentelemetry-api\" % \"1.27.0\""
RUN sbt "set libraryDependencies += \"io.opentelemetry\" % \"opentelemetry-sdk\" % \"1.27.0\""
RUN sbt "set libraryDependencies += \"io.opentelemetry\" % \"opentelemetry-bom\" % \"1.27.0\" pomOnly()"
RUN sbt "set libraryDependencies += \"io.opentelemetry\" % \"opentelemetry-sdk-extension-autoconfigure\" % \"1.27.0-alpha\""
RUN sbt "set libraryDependencies += \"io.opentelemetry\" % \"opentelemetry-exporter-otlp\" % \"1.27.0\""
RUN sbt "set libraryDependencies += \"io.opentelemetry\" % \"opentelemetry-semconv\" % \"1.27.0-alpha\""
RUN sbt "set libraryDependencies += \"io.opentelemetry.contrib\" % \"opentelemetry-aws-xray\" % \"1.26.0\""
RUN sbt "set libraryDependencies += \"io.opentelemetry\" % \"opentelemetry-sdk-testing\" % \"1.27.0\""
RUN sbt "set libraryDependencies += \"io.opentelemetry.contrib\" % \"opentelemetry-aws-xray-propagator\" % \"1.27.0-alpha\""
RUN sbt "set libraryDependencies += \"io.opentelemetry.javaagent\" % \"opentelemetry-javaagent-extension-api\" % \"1.27.0-alpha\""
RUN sbt "set libraryDependencies += \"commons-codec\" % \"commons-codec\" % \"1.15\""

# Build the Scala application
RUN sbt compile

# Specify the logging driver and options
CMD ["sbt",  "run"]