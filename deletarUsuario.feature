Feature: Deletar um usuario
    Como uma pessoa qualquer
    Desejo remover um usuário
    Para que suas informações não estejam mais registradas

    Background: Base url 
        Given url baseUrl
        And path "users"
    
        Scenario: Deletar usuário cadastrado
            # Criando usuário para ser deletado
            * def userNameAleatorio = "Rafael" + java.util.UUID.randomUUID()
            * def userEmailAleatorio = java.util.UUID.randomUUID() + "@gmail.com"
            * def usera = read("usera.json")
            And request usera
            When method post
            * def userId = response.id

            # Deletando usuário
            And path "users"
            And path userId
            When method delete
            * print usera
            Then status 204


        Scenario: Deletar usuário com Id inválido
            And path 1
            When method delete
            Then status 400

#   java -jar karate.jar deletarUsuário.feature 
