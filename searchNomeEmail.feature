Feature: Pesquisar usuário
    Como uma pessoa qualquer
    Desejo pesquisar usuário por nome ou e-mail
    Para ser capaz de encontrar um usuário cadastrado facilmente

    Background: Base url 
            Given url baseUrl
            And path "search"
            * def userName = "rafamour"
            * def userEmail = "rafamoua@email.com"	
            * def user = {name: "#(userName)", email: "#(userEmail)"}

        
        Scenario: Consultar usuário cadastrado pelo nome
            And path userName
            When method get
            Then status 200
            And match each response contains { id:'#string', name: "#(userName)", email: '#string', createdAt: '#string', updatedAt: '#string' }


        Scenario: Consultar usuário cadastrado pelo e-mail
            And path userEmail
            When method get
            Then status 200
            And match each response contains { id:'#string', name: '#string', email: "#(userEmail)", createdAt: '#string', updatedAt: '#string' }

        Scenario: Consultar usuário não cadastrado
            And path "io"
            When method get
            Then status 200
            And match each response = []

#   java -jar karate.jar searchNomeEmail.feature 

   
        