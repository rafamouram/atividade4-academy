Feature: Deletar um usuario
    Como uma pessoa qualquer
    Desejo remover um usuário
    Para que suas informações não estejam mais registradas

    Background: Base url 
            Given url baseUrl
            And path "users"
            * def usera = read("usera.json")
            * def userId = usera.id

    
        Scenario: Deletar usuário cadastrado
            And path userId
            When method delete
            * print usera
            Then status 204


        Scenario: Deletar usuário com Id inválido
            And path 1
            When method delete
            Then status 400

#   java -jar karate.jar deletarUsuário.feature 
