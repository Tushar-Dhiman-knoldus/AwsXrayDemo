ThisBuild / version := "0.1.0-SNAPSHOT"

ThisBuild / scalaVersion := "2.13.11"

lazy val root = (project in file("."))
  .settings(
    name := "AwsXray"
  )

javaOptions += "-Dotel.java.global-autoconfigure.enabled=true"


libraryDependencies ++= Seq(
  "org.apache.logging.log4j" % "log4j-api" % "2.20.0",
  "org.apache.logging.log4j" % "log4j-core" % "2.20.0",
  "org.apache.logging.log4j" % "log4j-slf4j-impl" % "2.20.0",
  "com.typesafe.akka" %% "akka-actor" % "2.8.0",
  "io.opentelemetry" % "opentelemetry-api" % "1.27.0",
  "io.opentelemetry" % "opentelemetry-sdk" % "1.27.0",
  "io.opentelemetry" % "opentelemetry-bom" % "1.27.0" pomOnly(),
  "io.opentelemetry" % "opentelemetry-sdk-extension-autoconfigure" % "1.27.0-alpha",
  "io.opentelemetry" % "opentelemetry-exporter-otlp" % "1.27.0",
  "io.opentelemetry" % "opentelemetry-semconv" % "1.27.0-alpha",
  "io.opentelemetry.contrib" % "opentelemetry-aws-xray" % "1.26.0",
  "io.opentelemetry" % "opentelemetry-sdk-testing" % "1.27.0",
  "io.opentelemetry.contrib" % "opentelemetry-aws-xray-propagator" % "1.27.0-alpha",
  "io.opentelemetry.javaagent" % "opentelemetry-javaagent-extension-api" % "1.27.0-alpha",
  "commons-codec" % "commons-codec" % "1.15"
)
