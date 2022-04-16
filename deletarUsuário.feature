Feature: Deletar um usuario
    Como uma pessoa qualquer
    Desejo remover um usuário
    Para que suas informações não estejam mais registradas

    Background: Base url 
            Given url baseUrl
            And path "users"
            * def userId = "38a1b99f-71eb-4e79-8eea-5177e050c153"
    
        Scenario: Deletar usuário cadastrado
            And path userId
            When method delete
            Then status 204

        Scenario: Deletar usuário com Id inválido
            And path 1
            When method delete
            Then status 400

#   java -jar karate.jar deletarUsuário.feature 
