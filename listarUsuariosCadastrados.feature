Feature: Listar usuários cadastrados
    Como uma pessoa qualquer
    Desejo consultar todos os usuários cadastrados
    Para ter as informações de todos os usuários

    Background: Base url 
       Given url baseUrl
       And path "users"

     Scenario: Listar usuários cadastrados
        When method get
        Then status 200
        And match each response contains { id:'#string', name: '#string', email: '#string', createdAt: '#string', updatedAt: '#string' }

#   java -jar karate.jar listarUsuáriosCadastrados.feature 