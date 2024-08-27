*** Settings ***
Resource    resource/Api_test.resource


*** Test Cases ***
Caso de teste 1 - Etapa IV - Automação de Teste de API
    [Documentation]  Esse teste visa fazer os testes da API ServeRest - Cadastro de usuário
    [Tags]           Cadastro usuario
    Criação de um usuário
    Cadastrando usuario
    Iniciar Sessao ServeRest
    Verificar se o usuário foi criado

Caso de teste 2 - Etapa IV - Automação de Teste de API
    [Documentation]  Esse teste visa fazer os testes da API ServeRest - Cadastro de Produto
    [Tags]           Cadastro produto
    Criação de um usuário
    Cadastrando usuario
    Login - Obter token
    Criação de um produto
    Cadastrando de produto
    Verificar se o produto foi criado

