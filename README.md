# Mi primer proyecto con Spring Boot (holamundo)

Aplicación Spring Boot con tres endpoints REST que aplica controladores, servicios, inyección de dependencias y configuración externa.

## Requisitos

- JDK 17 o superior (probado con Temurin 21.0.12.1)
- Maven (incluido vía Maven Wrapper: `mvnw.cmd`)
- IDE: IntelliJ IDEA (Community sirve) o NetBeans
- Postman o Insomnia para probar los endpoints

## Estructura

```
holamundo/src/main/java/com/ejemplo/holamundo/
├── HolamundoApplication.java
├── config/MiConfiguracion.java
├── controller/
│   ├── HolaMundoController.java
│   ├── SaludoController.java
│   ├── ConfigController.java
│   └── BeanController.java
└── service/MiServicio.java
src/main/resources/application.properties
```

## Cómo ejecutar

Desde la carpeta `holamundo/`:

```
mvnw.cmd spring-boot:run
```

O empaquetar y correr el jar:

```
mvnw.cmd package
java -jar target\holamundo-0.0.1-SNAPSHOT.jar
```

En Windows también sirve el doble clic en `ejecutar.bat`.

Al arrancar aparece en la consola:

```
:: Spring Boot :: (v4.1.1)
Tomcat initialized with port 8080 (http)
Tomcat started on port 8080 (http)
```

La aplicación queda disponible en `http://localhost:8080`. Para detenerla usa `Ctrl+C` o cierra la ventana.

## Endpoints

| Método | Endpoint | Respuesta |
|--------|----------|-----------|
| GET | http://localhost:8080/api/hola | ¡Hola Mundo desde Spring Boot! |
| GET | http://localhost:8080/saludo | ¡Hola desde el servicio! |
| GET | http://localhost:8080/config | ¡Bienvenido a Spring Boot! |
| GET | http://localhost:8080/bean | ¡Este es un mensaje de un bean! |

En Postman o Insomnia crea peticiones GET a cada una; el estado debe ser `200 OK`.

Reto: cambia el método de `/api/hola` a `POST`. La respuesta es `405 Method Not Allowed`, porque el controlador solo declara `@GetMapping`.

## Configuración externa

En `src/main/resources/application.properties`:

```properties
spring.application.name=holamundo
mensaje.bienvenida=¡Bienvenido a Spring Boot!
```

`ConfigController` lee `mensaje.bienvenida` con `@Value("${mensaje.bienvenida}")`. Cambia el texto, reinicia la app y verás el nuevo mensaje sin tocar código Java.

## Inyección de dependencias

`MiServicio` lleva `@Service`, así Spring lo crea como bean. `SaludoController` lo recibe por constructor con `@Autowired`; nunca se usa `new`. Si se quita `@Service` la aplicación no arranca con el error:

```
Parameter 0 of constructor in SaludoController required a bean
of type 'MiServicio' that could not be found.
```

## Bean con @Configuration

`MiConfiguracion` (`@Configuration`) define un bean `String` con `@Bean`. `BeanController` lo inyecta por constructor y lo expone en `GET /bean`.

## @RestController vs @Service

`@RestController` y `@Service` son estereotipos de `@Component` (beans), pero con rol distinto. `@RestController` marca la capa web: mapea URLs con `@GetMapping` y devuelve la respuesta en el cuerpo HTTP. `@Service` marca la capa de negocio, sin dependencia de HTTP.

Spring crea y guarda los beans en el `ApplicationContext` al arrancar. Cuando crea `SaludoController`, ve que su constructor necesita un `MiServicio` y se lo inyecta. Por eso el controlador no usa `new`: la dependencia la entrega el contenedor.

## Entregables

- Captura de la estructura del proyecto en el IDE.
- Captura de la consola con `Tomcat started on port 8080`.
- Capturas de `/api/hola`, `/saludo` y `/config` en Postman con `200 OK`.
- Capturas de las mismas tres respuestas en Insomnia.
- Captura del `405 Method Not Allowed` del reto de método equivocado.
- Captura del error del reto de `@Service`.
- Repositorio público en GitHub.

## Problemas frecuentes

- `Port 8080 was already in use`: detén la ejecución anterior o agrega `server.port=8081` en `application.properties`.
- Whitelabel Error Page (404): revisa la URL y que el controlador esté dentro de `com.ejemplo.holamundo`.
- `required a bean of type ... that could not be found`: falta la anotación (`@Service`, `@Component`, etc.) en la clase que se inyecta.
- Errores en rojo tras crear el proyecto: Maven sigue descargando dependencias; espera a que termine.
- Tildes o `¡` se ven mal: guarda los archivos en UTF-8.
- Postman muestra `Couldn't connect to server`: la aplicación no está corriendo. Usa la app de escritorio, no la web.
