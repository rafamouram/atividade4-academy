Feature: Atualizar um usuário
    Como uma pessoa qualquer
    Desejo atualizar as informações de determinado usuário
    Para ter o registro de suas informações atualizadas

    Background: Base url 
            Given url baseUrl
            And path "users"
            * def userId = "38a1b99f-71eb-4e79-8eea-5177e050c153"
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
            * user.updatedName = randomName(5)
            * print userUpdate
            * def randomString = random_string(10)
            * user.updatedEmail = randomString + "@gmail.com"
            * print userUpdate

        Scenario: Atualizar informações do usuário cadastrado
            And path userId
            And request userUpdate
             * def userRepetido = {name: "#(user.name)", email: "#(user.email)"}
            When method put
            Then status 200

        #Atualizar usuário com email já cadastrado
            And path "users"
            And path userId
            And request userRepetido
            When method put
            Then status 422
            And response message contains { error: "E-mail already ind use." }

        Scenario: Atualizar usuário com Id inexistente
            And path 3fa85f64-5717-4562-b3fc-2c963f66afa8
            When method get
            Then status 404

       

#   java -jar karate.jar atualizarUsuário.feature 