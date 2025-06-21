@MarvelCharacters
#noinspection CucumberUndefinedStep
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
    And match response.name ==  <name>

    * def heroId = response.id
    * def heroName = response.name
    * eval var heroData = { id: heroId, name: heroName }
    * def name = <name>
    * eval LocalStorage.put(name, heroData)

    Examples:
      | name     |
      | 'Camilo' |
      | 'Andres' |

  @id:2 @MarvelCharacters @POST @Failed
  Scenario: Should return an error when trying to create a hero with the same name.
    * def payload = marvel.buildPayload('Camilo')
    Given request payload
    When method post
    Then status 400
    And match response.error == 'Character name already exists'

  @id:3 @MarvelCharacters @POST @Failed
  Scenario: Should return an error when trying to create a hero with incomplete information.
    * def payload = marvel.buildEmptyPayload()
    Given request payload
    When method post
    Then status 400
    And match response == { "name": "Name is required", "description": "Description is required", "powers": "Powers are required", "alterego": "Alterego is required" }

  @id:4 @MarvelCharacters @PUT @Successfully
  Scenario Outline: Should update a new hero with <name> task
    * def id = LocalStorage.get(<name>).id
    * def payload = marvel.buildPayload(<name>)
    * def newAlterego = payload.alterego
    Given path id
    And request payload
    When method put
    Then status 200
    And match response.alterego == newAlterego
    Examples:
      | name     |
      | 'Camilo' |

  @id:5 @MarvelCharacters @PUT @Failed
  Scenario Outline: Should return an error when trying to update a hero that does not exist..
    * def payload = marvel.buildPayload()
    * def newAlterego = payload.alterego
    Given path <id>
    And request payload
    When method put
    Then status 404
    And match response.error == 'Character not found'
    Examples:
      | id  |
      | 998 |
      | 999 |

  @id:6 @MarvelCharacters @GET @Successfully
  Scenario: Should get the entire list of heroes
    Given method get
    Then status 200
    And match response[*].name contains 'Camilo'
    And match response[*].name contains 'Andres'

  @id:7 @MarvelCharacters @GET @Successfully
  Scenario Outline: Should get the information from the hero <name>
    * def id = LocalStorage.get(<name>).id
    Given path id
    And method get
    Then status 200
    And match response.name == <name>
    Examples:
      | name     |
      | 'Camilo' |
      | 'Andres' |

  @id:8 @MarvelCharacters @GET @Failed
  Scenario Outline: Should return an error when trying to query a hero that does not exist.
    Given path <id>
    And method get
    Then status 404
    And match response.error == 'Character not found'
    Examples:
      | id  |
      | 998 |
      | 999 |

  @id:9 @MarvelCharacters @DELETE @Failed
  Scenario Outline: Should return an error when trying to delete a hero that does not exist.
    Given path <id>
    And method delete
    Then status 404
    And match response.error == 'Character not found'
    Examples:
      | id  |
      | 998 |
      | 999 |

  @id:7 @MarvelCharacters @DELETE @Successfully @DeleteByName
  Scenario Outline: Should remove the hero named <name>
    * def id = LocalStorage.get(<name>).id
    Given path id
    And method delete
    Then status 204
    Examples:
      | name     |
      | 'Camilo' |
      | 'Andres' |