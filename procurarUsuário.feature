Feature: Pesquisar usuário
    Como uma pessoa qualquer
    Desejo pesquisar usuário por nome ou e-mail
    Para ser capaz de encontrar um usuário cadastrado facilmente

    Background: Base url 
            Given url baseUrl
            And path "users"
            * def userName = "rafamour"
            * def userEmail = "rafamoua@email.com"	
            * def user = {name: "#(userName)", email: "#(userEmail)"}

        
        # Scenario: Consultar usuário cadastrado pelo username
        #     And path userName
        #     When method get
        #     Then status 200
        #     And match response contains payload

   
        