Feature: Criar Usuário
    Como uma pessoa qualquer
    Desejo registrar informações de usuário
    Para poder manipular estas informações livremente

    Background: Base url e Define usuário aleatório
        Given url baseUrl
        And path "users"
        # Função para criar nome aleatório
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
        # Função para criar email aleatório
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
        # Cria usuário com nome e email aleatórios
        * def user = {name: "", email: ""}
        * user.name = randomName(5)
        * print user
        * def randomString = random_string(10)
        * user.email = randomString + "@gmail.com"
        * print user

        Scenario: Cadastrar um novo usuário e Não cadastra usuário com email já cadastrado
            And request user
            # Cria um usuário repetido, com mesmo nome e email do usuário criado anteriormente
            * def userRepetido = {name: "#(user.name)", email: "#(user.email)"}
            When method post
            Then status 201
            And match response contains { name: "#(user.name)", email: "#(user.email)" }
            * def userId = response.id
        
            #Cadastra um novo usuário com email já cadastrado
            And path "users"
            And request userRepetido
            When method post
            Then status 422
            And match response contains { error: "User already exists." }

            # Deleta usuário criado anteriormente 
            And path "users"
            And path userId
            When method delete
            Then status 204

         Scenario: Cadastrar um novo usuário sem colocar um email	
            * def userInvalido = {name: "#(user.name)", email: ""}
            And request userInvalido
            When method put
            Then status 404

        Scenario: Cadastrar um novo usuário sem colocar um nome	
            * def userInvalido = {name: "", email: "rafa@gmail.com"}
            And request userInvalido
            When method put
            Then status 404


        Scenario: Cadastrar um novo usuário com email sem "@"	
            * def userInvalido = {name: "#(user.name)", email: "arfa.com"}
            And request userInvalido
            When method post
            Then status 400

        Scenario: Cadastrar um novo usuário com email sem ".com"	
            * def userInvalido = {name: "#(user.name)", email: "rafa@email"}
            And request userInvalido
            When method post
            Then status 400

        Scenario: Cadastrar um novo usuário com email com mais de 60 caracteres	
            * def userInvalido = {name: "#(user.name)", email: "asdfertyuiasdfertyuiasdfertyuiasdfertyuiasdfertyuiasdfertyui@gmail.com"}
            And request userInvalido
            When method post
            Then status 400

        Scenario: Cadastrar um novo usuário com nome com mais de 100 caracteres	
            * def userInvalido = {name: "rafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmourarafaelmoura", email: "rafa@gmail.com"}
            And request userInvalido
            When method post
            Then status 400


# java -jar karate.jar registrarUsuário.feature 