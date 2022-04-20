Feature: Listar usuários cadastrados
   Como uma pessoa qualquer
   Desejo consultar todos os usuários cadastrados
   Para ter as informações de todos os usuários  

      Scenario: Listar usuários cadastrados
         Given url baseUrl
         And path "users"
         #Cria usuário para lista não estar vazia
         * def userNameAleatorio = "Rafael" + java.util.UUID.randomUUID()
         * def userEmailAleatorio = java.util.UUID.randomUUID() + "@gmail.com"
         * def usera = read("usera.json")
         And request usera
            * def userName = usera.name
         * def userEmail = usera.email	
         * def user = {name: "#(userName)", email: "#(userEmail)"}
         When method post
         * def userId = response.id

         # Listando os usuários
         And path "search"
         When method get
         Then status 200
         And match each response contains { id:'#string', name: '#string', email: '#string', createdAt: '#string', updatedAt: '#string' }

         # Deleta usuário após cada cenário
         * configure afterScenario = function(){karate.call('deletaDepoisCenario.feature');}

#   java -jar karate.jar listarUsuariosCadastrados.feature 