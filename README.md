# Suite de Pruebas API Marvel con Karate

## Introducción

La **Suite de Pruebas API Marvel con Karate** es un proyecto integral de automatización de pruebas de API construido usando **Karate DSL**, diseñado para validar la funcionalidad de APIs REST mediante pruebas automatizadas. Este proyecto sigue los principios de **Screaming Architecture** y patrones de **Vertical Slicing** para asegurar una organización de pruebas mantenible, escalable y enfocada en características.

La suite de pruebas está estructurada alrededor de capacidades de negocio en lugar de preocupaciones técnicas, haciendo inmediatamente claro qué funcionalidad está siendo probada. Al adoptar **Vertical Slicing**, cada prueba de característica abarca el viaje completo del usuario desde la solicitud hasta la validación de respuesta, asegurando una cobertura integral de escenarios de negocio.

Este proyecto aprovecha el poder de [Karate](https://karatelabs.github.io/karate/) para proporcionar una plataforma unificada para pruebas de API, pruebas de rendimiento y automatización, mientras mantiene el enfoque en escenarios de prueba legibles para el negocio.

## Visión General de la Arquitectura

### Screaming Architecture

Este proyecto implementa **Screaming Architecture** donde la estructura de carpetas comunica inmediatamente el dominio de negocio y capacidades que están siendo probadas:

```
src/test/java/com/pichincha/
├── core/                     # Preocupaciones técnicas transversales
│   ├── environment/          # Configuraciones de entorno
│   └── runner/              # Ejecución de pruebas y runners paralelos
├── shared/                  # Utilidades compartidas entre dominios
│   └── caching/             # Sistema de caché para datos de prueba
└── marvel/                  # Dominio Marvel - Capacidad de negocio
    ├── feature/             # Archivos de características (escenarios Gherkin)
    └── step/               # Definiciones de pasos reutilizables y lógica de negocio
```

La arquitectura "grita" su intención organizando las pruebas alrededor de **dominios de negocio** (marvel) en lugar de capas técnicas. Cuando un desarrollador mira la estructura del proyecto, inmediatamente entiende:

- **Qué capacidades de negocio** están siendo probadas (`marvel`)
- **Qué características** están cubiertas (`marvel-characters.feature`)
- **Dónde encontrar** lógica de negocio (`step/`) y utilidades compartidas (`shared/`)

### Vertical Slicing

Cada slice de característica corta verticalmente a través de todas las capas de preocupaciones de prueba:

```
marvel/feature/marvel-characters.feature  ← Escenarios de negocio
marvel/step/marvel-characters-step.js     ← Helpers de lógica de negocio
shared/caching/LocalStorage.java          ← Utilidades de soporte compartidas
```

Este enfoque asegura que:
- **Flujos de trabajo de negocio completos** son probados de extremo a extremo
- **Todos los componentes necesarios** para una característica están co-ubicados
- **Las dependencias entre características** son minimizadas
- **El mantenimiento** se simplifica ya que el código relacionado está agrupado

## Estructura del Proyecto

```
test-automatisation-base/
├── src/test/java/
│   ├── karate-config.js                    # Configuración global de Karate
│   └── com/pichincha/
│        ├── core/                           # Componentes core del proyecto
│       │   ├── environment/
│       │   │   └── environment.json        # Configuraciones de entorno
│       │   └── runner/
│       │       └── CoreRunnerTest.java     # Runner de pruebas paralelas
│       ├── shared/                         # Utilidades compartidas
│       │   └── caching/
│       │       └── LocalStorage.java       # Sistema de caché en memoria
│       └── marvel/                         # Dominio de negocio Marvel
│           ├── feature/
│           │   └── marvel-characters.feature # Escenarios de gestión de personajes
│           └── step/
│               └── marvel-characters-step.js # Lógica de negocio de Marvel
├── src/test/resources/
│   └── logback-test.xml                    # Configuración de logging
├── build.gradle                            # Dependencias del proyecto y build
├── gradlew                                 # Gradle wrapper (Unix)
├── gradlew.bat                            # Gradle wrapper (Windows)
└── settings.gradle                         # Configuraciones del proyecto
```

### Descripción de Paquetes

- **`core/`**: Contiene preocupaciones transversales que son compartidas entre todos los dominios de negocio:
  - **`environment/`**: Gestiona configuraciones específicas del entorno, endpoints y timeouts
  - **`runner/`**: Proporciona estrategias de ejecución de pruebas incluyendo runners paralelos

- **`shared/`**: Utilidades y servicios compartidos entre múltiples dominios:
  - **`caching/`**: Sistema de caché en memoria para almacenar datos entre escenarios de prueba

- **`marvel/`**: Representa el **dominio de negocio Marvel** con vertical slicing completo:
  - **`feature/`**: Contiene archivos de características Gherkin que describen escenarios de negocio en lenguaje natural
  - **`step/`**: Implementa lógica de negocio reutilizable, abstracciones de llamadas API y funciones de manipulación de datos

## Mejores Prácticas y Organización Side-by-Side

Siguiendo las [recomendaciones de la documentación oficial de Karate sobre estructura de carpetas](https://karatelabs.github.io/karate/#folder-structure), este proyecto implementa patrones de organización **side-by-side**:

### Beneficios de la Estructura Side-by-Side

1. **Co-ubicación**: Los archivos relacionados se colocan en la misma estructura de paquetes
2. **Descubribilidad**: Fácil encontrar archivos de soporte para cualquier característica
3. **Mantenibilidad**: Los cambios en la lógica de negocio solo requieren actualizar archivos en una ubicación
4. **Legibilidad**: Relación clara entre archivos de características y sus componentes de soporte

### Prácticas Recomendadas Aplicadas

| **Práctica**                    | **Implementación**                                              | **Beneficio**                                     |
|---------------------------------|-----------------------------------------------------------------|--------------------------------------------------|
| **Co-ubicación de Características** | `marvel/feature/` + `marvel/step/` en el mismo dominio        | Todos los archivos relacionados con características en el mismo dominio |
| **Pasos Reutilizables**         | `marvel/step/marvel-characters-step.js` con funciones exportadas | Promueve el principio DRY y consistencia        |
| **Utilidades Compartidas**      | `shared/caching/LocalStorage.java` para gestión de estado      | Gestión centralizada de datos entre escenarios  |
| **Separación de Entornos**      | `core/environment/environment.json` con configuraciones específicas del entorno | Fácil cambio de entorno y configuración |
| **Ejecución Paralela**          | `CoreRunnerTest.java` con configuración de runner paralelo     | Ejecución de pruebas más rápida y mejor CI/CD   |

## Convenciones de Nombres de Archivos

Basado en las [convenciones de nomenclatura de la documentación oficial de Karate](https://karatelabs.github.io/karate/#naming-conventions), este proyecto sigue estos estándares de nomenclatura:

### Archivos Java
- **Patrón**: `UpperCamelCase`
- **Ejemplo**: `CoreRunnerTest.java`, `LocalStorage.java`
- **Ubicación**: Clases Java en paquetes apropiados
- **Propósito**: Siguen las convenciones estándar de Java

### Archivos de Características
- **Patrón**: `{capacidad-de-negocio}.feature` (minúsculas con guiones)
- **Ejemplo**: `marvel-characters.feature`
- **Ubicación**: `{dominio}/feature/`
- **Propósito**: Describe escenarios de negocio en sintaxis Gherkin

### Archivos de Definición de Pasos  
- **Patrón**: `{dominio}-{capacidad}-step.js` (minúsculas con guiones)
- **Ejemplo**: `marvel-characters-step.js`
- **Ubicación**: `{dominio}/step/`
- **Propósito**: Contiene lógica de negocio reutilizable y funciones de interacción con API

### Archivos de Configuración
- **Patrón**: `{propósito}-config.js` o `{entidad}.json` (minúsculas con guiones)
- **Ejemplos**: `karate-config.js`, `environment.json`
- **Propósito**: Configuraciones globales y configuraciones específicas del entorno

### Convención de Etiquetas
Siguiendo las [mejores prácticas de etiquetado de Karate](https://karatelabs.github.io/karate/#tags):

```gherkin
@MarvelCharacters                 # Etiqueta de dominio de negocio
@id:1 @POST @Successfully        # ID de prueba, método HTTP, resultado
@id:2 @PUT @Failed               # ID de prueba, método HTTP, resultado
```

## Patrones de Arquitectura Aplicados

| **Patrón**                      | **Implementación**                                               | **Propósito**                                                    |
|---------------------------------|------------------------------------------------------------------|----------------------------------------------------------------|
| **Screaming Architecture**      | Estructura de carpetas basada en dominios (`marvel/`)          | La intención de negocio es inmediatamente visible en la estructura del proyecto |
| **Vertical Slicing**           | Slices completos de características con feature/step co-ubicados | Pruebas de características de extremo a extremo con dependencias cruzadas mínimas |
| **Patrón Facade**              | `marvel-characters-step.js` expone operaciones de negocio simplificadas | Abstrae interacciones complejas de API detrás de interfaces simples |
| **Patrón Singleton**           | `LocalStorage.java` proporciona caché global compartido        | Estado consistente compartido entre múltiples escenarios de prueba |
| **Patrón Strategy**            | Configuraciones específicas del entorno en `environment.json`   | Permite cambio fácil entre diferentes entornos                 |
| **Patrón Factory**             | Generación dinámica de payload en la función `buildPayload()`   | Crea datos de prueba basados en parámetros de escenario       |

## Configuración

### Dependencias de Gradle

```groovy
dependencies {
    implementation 'net.datafaker:datafaker:2.4.2'           // Para generar datos de prueba falsos
    implementation 'com.google.guava:guava:33.3.1-jre'      // Utilidades y caché en memoria
    testImplementation 'io.karatelabs:karate-junit5:1.5.1'  // Framework de pruebas Karate
}
```

### Configuración de Entorno

El proyecto soporta múltiples entornos a través de `environment.json`:

```json
{
  "dev": {
    "endpoints": {
      "marvel": "http://bp-se-test-cabcd9b246a5.herokuapp.com"
    },
    "headers": {
      "Content-Type": "application/json",
      "X-Env": "dev"
    },
    "timeouts": {
      "read": 5000,
      "connect": 3000
    }
  }
}
```

### Configuración de Karate

Las configuraciones globales de Karate se definen en `karate-config.js`:

```javascript
function fn() {
    const env = karate.env || 'dev';
    const configuration = karate.read('classpath:com/pichincha/core/environment/environment.json')[env];
    
    if (!configuration) {
        throw new Error(`No configuration found for the environment: ${env}`);
    }
    
    karate.configure('logPrettyRequest', true);
    karate.configure('logPrettyResponse', true);
    karate.configure('readTimeout', configuration.timeouts?.read || 5000);
    karate.configure('connectTimeout', configuration.timeouts?.connect || 3000);
    
    return configuration;
}
```

## Ejemplos de Uso

### Ejecutar Pruebas

#### Ejecutar Todas las Pruebas
```bash
./gradlew test
```

#### Ejecutar Etiquetas Específicas
```bash
./gradlew test -Dkarate.options="--tags @MarvelCharacters"
```

#### Ejecutar con Entorno Específico
```bash
./gradlew test -Dkarate.env=prod
```

#### Ejecución Paralela
```bash
./gradlew test -Dkarate.options="--threads 5"
```

### Ejemplo de Archivo de Características

```gherkin
@MarvelCharacters
Feature: As a S.H.I.E.L.D. Agent, I want to manage the Marvel Characters

  Background:
    * def marvel = callonce read('../step/marvel-characters-step.js')
    * def LocalStorage = Java.type('com.pichincha.shared.caching.LocalStorage')
    * url endpoints.marvel + '/cagomezr/api/characters'

  @id:1 @MarvelCharacters @POST @Successfully
  Scenario Outline: Should create a new hero with <name> task
    * def payload = marvel.buildPayload(<name>)
    Given request payload
    When method post
    Then status 201
    And match response.name == <name>

    Examples:
      | name     |
      | 'Camilo' |
      | 'Andres' |
```

### Ejemplo de Definición de Pasos

```javascript
function step() {
    const buildPayload = (name) => {
        const Faker = Java.type('net.datafaker.Faker');
        const faker = new Faker();

        return {
            "name": name ?? faker.expression('#{superhero.name}'),
            "alterego": faker.expression('#{superhero.name}'),
            "description": faker.expression('#{job.title}'),
            "powers": [faker.expression('#{superhero.power}'), faker.expression('#{superhero.power}')]
        }
    }

    const buildEmptyPayload = () => ({
        "name": "", "alterego": "", "description": "", "powers": []
    })

    return {
        buildPayload,
        buildEmptyPayload,
    };
}
```

## Gestión de Datos de Prueba

### Sistema de Caché LocalStorage

El proyecto utiliza un sistema de caché en memoria para compartir datos entre escenarios:

```java
public class LocalStorage {
    private static final Cache<String, Object> cache = CacheBuilder.newBuilder().build();
    
    public static void put(String key, Object value) {
        cache.put(key, value);
    }
    
    public static Object get(String key) {
        return cache.getIfPresent(key);
    }
}
```

### Uso en Escenarios de Prueba

```gherkin
# Almacenar datos después de la creación
* def heroId = response.id
* def heroName = response.name
* eval var heroData = { id: heroId, name: heroName }
* eval LocalStorage.put(name, heroData)

# Recuperar datos en escenarios posteriores
* def id = LocalStorage.get('Camilo').id
```

## Reportes y Resultados

Karate genera reportes comprensivos de pruebas en el directorio `build/karate-reports/`:

- **Reportes HTML**: Resultados visuales de ejecución de pruebas con logs detallados
- **Reportes JSON**: Resultados estructurados para integración CI/CD
- **Reportes Cucumber**: Compatibles con herramientas estándar de reporte Cucumber

## Extendiendo el Proyecto

### Agregando Nuevos Dominios de Negocio

1. Crear un nuevo paquete bajo `com.pichincha.{dominio}/`
2. Seguir el patrón de vertical slicing:
   ```
   {dominio}/
   ├── feature/
   └── step/
   ```
3. Implementar definiciones de pasos específicas del dominio
4. Agregar configuraciones de entorno si es necesario
5. Actualizar el runner si es necesario

### Agregando Nuevos Escenarios de Prueba

1. Agregar nuevos escenarios a archivos de características existentes
2. Crear funciones de pasos reutilizables en archivos de definición de pasos
3. Usar utilidades compartidas como `LocalStorage` para gestión de estado
4. Usar etiquetas apropiadas para organización de pruebas

## Resumen de Mejores Prácticas

### De la Documentación Oficial de Karate

1. **[Organización de Pruebas](https://karatelabs.github.io/karate/#folder-structure)**: Usar estructura de paquetes side-by-side para organizar pruebas por dominio de negocio
2. **[Funciones Reutilizables](https://karatelabs.github.io/karate/#calling-javascript-functions)**: Crear funciones JavaScript reutilizables para operaciones comunes
3. **[Pruebas Dirigidas por Datos](https://karatelabs.github.io/karate/#data-driven-tests)**: Usar tablas Examples para pruebas parametrizadas
4. **[Gestión de Entornos](https://karatelabs.github.io/karate/#switching-the-environment)**: Separar configuración por entorno
5. **[Convenciones de Nomenclatura](https://karatelabs.github.io/karate/#naming-conventions)**: Seguir estándares para archivos Java (UpperCamelCase) y otros archivos (minúsculas con guiones)
6. **[Ejecución Paralela](https://karatelabs.github.io/karate/#parallel-execution)**: Aprovechar runners paralelos para ejecución más rápida

### Mejores Prácticas Adicionales

- **Mantener archivos de características enfocados** en escenarios de negocio
- **Usar etiquetas significativas** para organización y ejecución de pruebas
- **Implementar manejo de errores apropiado** en definiciones de pasos
- **Mantener separación limpia** entre datos de prueba y lógica de prueba
- **Documentar reglas de negocio complejas** en descripciones de características
- **Usar librerías faker** para generar datos de prueba dinámicos

## Conclusión

La **Suite de Pruebas API Marvel con Karate** demuestra cómo construir un proyecto de automatización de pruebas de API mantenible, escalable y enfocado en el negocio usando Karate DSL. Al implementar patrones de **Screaming Architecture** y **Vertical Slicing**, el proyecto asegura que la intención de negocio sea clara, el mantenimiento se simplifique y las nuevas características se puedan agregar con impacto mínimo en las pruebas existentes.

El proyecto sigue las mejores prácticas de la [documentación oficial de Karate](https://karatelabs.github.io/karate/) mientras proporciona una base sólida para pruebas comprensivas de API que crecen con los requerimientos de tu negocio.
