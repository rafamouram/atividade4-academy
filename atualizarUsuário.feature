Feature: Atualizar um usuário
    Como uma pessoa qualquer
    Desejo atualizar as informações de determinado usuário
    Para ter o registro de suas informações atualizadas

    Background: Base url 
            Given url baseUrl
            And path "users"
            * def userId = "38a1b99f-71eb-4e79-8eea-5177e050c153"
            * def userNameUpdate = "rafamoura_update"
            * def userEmailUpdate = "rafa@email.com"	
            * def userUpdate = {name: "#(userNameUpdate)", email: "#(userEmailUpdate)"}

        Scenario: Atualizar informações do usuário cadastrado
            And path userId
            And request userUpdate
            When method put
            Then status 200

            Given path "users"
            And path userId
            When method get
            Then status 200
            And match response contains userUpdate