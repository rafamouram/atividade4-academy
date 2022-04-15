Feature: Criar Usuário
    Como uma pessoa qualquer
    Desejo registrar informações de usuário
    Para poder manipular estas informações livremente

    Background: Base url 
            Given url baseUrl
            And path "users"
            * def userName = "rafamour"
            * def userEmail = "rafamoua@email.com"
            * def user = {name: "#(userName)", email: "#(userEmail)"}

        Scenario: Cadastrar um novo usuário
            And request user
            When method post
            Then status 201
            And match response contains { name: "#(userName)", email: "#(userEmail)" }