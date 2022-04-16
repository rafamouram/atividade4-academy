Feature: Criar Usuário
    Como uma pessoa qualquer
    Desejo registrar informações de usuário
    Para poder manipular estas informações livremente

    Background: Base url 
            Given url baseUrl
            And path "users"
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
            * def user = {name: "", email: ""}
            * user.name = randomName(5)
            * print user
            * def randomString = random_string(10)
            * user.email = randomString + "@gmail.com"
            * print user

        Scenario: Cadastrar um novo usuário
            And request user
            * def userRepetido = {name: "#(user.name)", email: "#(user.email)"}
            When method post
            Then status 201
            And match response contains { name: "#(user.name)", email: "#(user.email)" }
            * def idSalvo = response.id
            * def usera = read("usera.json")
            * print usera.id
            
        
        #Cadastrar um novo usuário com email já cadastrado
            And path "users"
            And request userRepetido
            When method post
            Then status 422
            And match response contains { error: "User already exists." }

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