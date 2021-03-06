Feature: Atualizar um usuário
    Como uma pessoa qualquer
    Desejo atualizar as informações de determinado usuário
    Para ter o registro de suas informações atualizadas

    Background: Base url e Cria Usuário aleatório para ser atualizado e Deleta usuário após cenário
        Given url baseUrl
        And path "users"

        #Cria usuário para ser atualizado
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

        # Deleta usuário após a execução 
        * configure afterScenario = function(){karate.call('deletaDepoisCenario.feature');}
    
        # Cria nome e email que serão utilizados para atualizar o usuário
        * def random_string = 
        """
            function(s){
                var text = "";
                var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
                for( var i=0; i < s; i++ )
                    text += possible.charAt(Math.floor(Math.random() * possible.length));
                    return text;
            }
        """
        * def randomName = 
        """
            function(s){
                var text = "";
                var possible = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
                var possible2 = "abcdefghijklmnopqrstuvwxyz";
                text += possible.charAt(Math.floor(Math.random() * possible.length));
                for( var i=1; i < s; i++ )
                    text += possible2.charAt(Math.floor(Math.random() * possible.length));
                    return text;
            }
        """
        * def userUpdate = {name: "", email: ""}
        * userUpdate.name = randomName(5)
        * print userUpdate
        * def randomString = random_string(10)
        * userUpdate.email = randomString + "@gmail.com"
        * print userUpdate

        Scenario: Atualizar informações do usuário cadastrado
            And path userId
            And request userUpdate
            When method put
            Then status 200
            And match response contains userUpdate

        Scenario: Atualizar usuário com email já cadastrado
            #Cria usuário para ser atualizado
            * def userRepetido = { name: "Rafa", email: "rafa@email.com"}
            And request userRepetido
            When method post
            * def userId2 = response.id
            
            # Atualiza usuário com email já cadastrado
            And path "users"
            And path userId2
            And request usera
            When method put
            Then status 422
            And match response contains { error: "E-mail already in use." }

            # Deletando usuário
            And path "users"
            And path userId2
            When method delete
            * print usera
            Then status 204

        Scenario: Atualizar usuário com Id inexistente
            And path java.util.UUID.randomUUID()
            And request userUpdate
            When method put
            Then status 404

        Scenario: Atualizar um usuário sem colocar um email	
            * def userInvalido = {name: "#(userUpdate.name)", email: ""}
            And path userId
            And request userInvalido
            When method put
            Then status 400

        Scenario: Atualizar um usuário sem colocar um nome	
            * def userInvalido = {name: "", email: "rafa@gmail.com"}
            And path userId
            And request userInvalido
            When method put
            Then status 400

         Scenario: Atualizar um usuário para um email sem "@"	
            * def userInvalido = {name: "#(userUpdate.name)", email: "arfa.com"}
            And path userId
            And request userInvalido
            When method put
            Then status 400

        Scenario: Atualizar um usuário para um email sem ".com"	
            * def userInvalido = {name: "#(userUpdate.name)", email: "rafa@email"}
            And path userId
            And request userInvalido
            When method put
            Then status 400

        Scenario: Atualizar um usuário para um email com mais de 60 caracteres	
            * def userInvalido = {name: "#(userUpdate.name)", email: "asdfertyuiasdfertyuiasdfertyuiasdfertyuiasdfertyuiasdfertyui@gmail.com"}
            And path userId
            And request userInvalido
            When method put
            Then status 400

        Scenario: Atualizar um usuário para um nome com mais de 100 caracteres	
            * def userInvalido = {name: "rafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmoura", email: "rafa@gmail.com"}
            And path userId
            And request userInvalido
            When method put
            Then status 400

       

#   java -jar karate.jar atualizarUsuario.feature 