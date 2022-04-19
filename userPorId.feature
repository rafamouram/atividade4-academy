Feature: Pesquisar um usuário
    Como uma pessoa qualquer
    Desejo consultar os dados de um usuário
    Para visualizar as informações deste usuário	

    Background: Base url  e Cria Usuário e Deleta usuário após cada cenário
            Given url baseUrl
            And path "users"

            #Cria usuário
            * def userNameAleatorio = "Rafael" + java.util.UUID.randomUUID()
            * def userEmailAleatorio = java.util.UUID.randomUUID() + "@gmail.com"
            * def usera = read("usera.json")
            And request usera
             * def userName = usera.name
            * def userEmail = usera.email	
            * def user = {name: "#(userName)", email: "#(userEmail)"}
            When method post
            * def userId = response.id
            And path "users"

            # Deleta usuário
            * configure afterScenario = function(){karate.call('deletaDepoisCenario.feature');}
        
        Scenario: Pesquisar um usuário por Id
            # Pesquisando usuário
            And path userId
            When method get
            Then status 200
            And match response contains { id:"#(userId)", name: '#string', email: '#string', createdAt: '#string', updatedAt: '#string' }
        
        Scenario: Pesquisar usuário por Id inexistente
            And path "3fa85f64-5717-4562-b3fc-2c963f66afa8"
            When method get
            Then status 404

        Scenario: Pesquisar usuário por Id inválido
            And path 1
            When method get
            Then status 400

#   java -jar karate.jar userPorId.feature 