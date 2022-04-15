Feature: Pesquisar um usuário
    Como uma pessoa qualquer
    Desejo consultar os dados de um usuário
    Para visualizar as informações deste usuário	

    Background: Base url 
            Given url baseUrl
            And path "users"
            * def userId = "38a1b99f-71eb-4e79-8eea-5177e050c153"
        
        Scenario: Pesquisar um usuário por Id
            