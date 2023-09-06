import akka.actor.{Actor, ActorSystem, PoisonPill, Props}
import org.apache.logging.log4j.LogManager
import org.apache.logging.log4j.Logger
import io.opentelemetry.api.trace.Tracer

object AwsXRayTracing extends App {

  val log: Logger = LogManager.getLogger(getClass)
  val tracer: Tracer = AwsXRayTracingSetup.setup().getTracer("AwsXray") // Use the OpenTelemetry tracer

  class MyActor extends Actor {

    def receive: Receive = {
      case "start" =>
        log.info("Actor started")
      case "process" =>
        val currentSpan = tracer.spanBuilder("MainSpan").startSpan()
        currentSpan.setAttribute("myKey", "demo")
        try {
          log.error("Error Message Log")
        }
        finally
        {
           currentSpan.end()
        }
      case "stop" =>
      self ! PoisonPill
    }
  }

  val system = ActorSystem("MySystem")
  val actor = system.actorOf(Props[MyActor], "MyActor")

  actor ! "start"
  actor ! "start"
  for (_ <- 1 to 100) {
    actor ! "process"
    Thread.sleep(10000)
  }
  actor ! "stop"
  //    system.terminate()
}
