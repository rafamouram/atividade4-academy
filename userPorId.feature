Feature: Pesquisar um usuário
    Como uma pessoa qualquer
    Desejo consultar os dados de um usuário
    Para visualizar as informações deste usuário	

    Background: Base url 
            Given url baseUrl
            And path "users"
            * def userId = "38a1b99f-71eb-4e79-8eea-5177e050c153"
        
        Scenario: Pesquisar um usuário por Id
            And path userId
            When method get
            Then status 200
            And match each response contains { id:"#(userId)", name: '#string', email: '#string', createdAt: '#string', updatedAt: '#string' }

        
        Scenario: Pesquisar usuário por Id inexistente
            And path 3fa85f64-5717-4562-b3fc-2c963f66afa8
            When method get
            Then status 404

        Scenario: Pesquisar usuário por Id inválido
            And path 1
            When method get
            Then status 400

#   java -jar karate.jar userPorId.feature 