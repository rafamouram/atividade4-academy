Feature: Pesquisar usuário
    Como uma pessoa qualquer
    Desejo pesquisar usuário por nome ou e-mail
    Para ser capaz de encontrar um usuário cadastrado facilmente

    Background: Base url  e Cria Usuário e Deleta usuário após cada cenário
            Given url baseUrl
            And path "users"

            #Cria usuário para ser deletado
            * def usera = read("usera.json")
            And request usera
             * def userName = usera.name
            * def userEmail = usera.email	
            * def user = {name: "#(userName)", email: "#(userEmail)"}
            When method post
            * def userId = response.id
            And path "search"

            # Deleta usuário após cada cenário
            * configure afterScenario = function(){karate.call('deletaDepoisCenario.feature');}
        
        Scenario: Consultar usuário cadastrado pelo nome 
            And param value = userName
            When method get
            Then status 200
            And match each response contains { id:'#string', name: "#(userName)", email: '#string', createdAt: '#string', updatedAt: '#string' }


        Scenario: Consultar usuário cadastrado pelo e-mail
            And param value = userEmail
            When method get
            Then status 200
            And match each response contains { id:'#string', name: '#string', email: "#(userEmail)", createdAt: '#string', updatedAt: '#string' }

        Scenario: Consultar usuário não cadastrado
             And path "io"
             When method get
             Then status 404

#   java -jar karate.jar searchNomeEmail.feature 

   
        