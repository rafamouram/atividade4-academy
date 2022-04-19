@ignore
# Feature para deletar o usuário após o cenário em outras funcionalidades
Feature: Deletar um usuario
    
    Scenario: Deletar usuário cadastrado
        Given url baseUrl
        And path "users"
        And path userId
        When method delete