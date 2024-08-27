*** Settings ***
Library    RequestsLibrary
Library    String
Library    SeleniumLibrary
Library    Collections


*** Keywords ***
Criação de um usuário
    ${PALAVRA}    Generate Random String    length=4    chars=[LETTERS]
    ${PALAVRA}    Convert To Lower Case    ${PALAVRA}
    Set Test Variable      ${EMAIL}        ${PALAVRA}@teste.com
    Log To Console    Meu e-mail é: ${EMAIL}
    

Cadastrando usuario
    
    ${Body}    Create Dictionary    nome=Nome de teste     email=${EMAIL}
    ...        password=teste123    administrador=true
    Iniciar Sessao ServeRest   
    ${RESPOSTA}    POST On Session    alias=ServeRest    url=/usuarios     
    ...    json=${Body}
    Log    Reponsta_Json: ${RESPOSTA.json()}
    Set Test Variable    ${RESPOSTAJSON}        ${RESPOSTA.json()}


    
    
Iniciar Sessao ServeRest
    ${headers}    Create Dictionary    accept=application/json    Content-Type=application/json
    Create Session    alias=ServeRest    url=https://serverest.dev    headers=${headers}

Verificar se o usuário foi criado
    Log  ${RESPOSTAJSON}
    Dictionary Should Contain Item    ${RESPOSTAJSON}    message     Cadastro realizado com sucesso
    Dictionary Should Contain Key     ${RESPOSTAJSON}    _id

##    CADASTRO DE PRODUTO ##

Login - Obter token
    ${body}  Create Dictionary
    ...      email=${EMAIL}
    ...      password=teste123

    ${resposta}  POST On Session
    ...          alias=ServeRest
    ...          url=/login
    ...          json=${body}
    ...          expected_status=200

    Set Test Variable    ${RESPOSTA}    ${resposta.json()} 

    Log  ${RESPOSTA}
    Dictionary Should Contain Item  ${RESPOSTA}  message  Login realizado com sucesso
    Dictionary Should Contain Key   ${RESPOSTA}  authorization
    ${TOKEN}    Get From Dictionary    ${RESPOSTA}    authorization    default
    Set Suite Variable    ${TOKEN}
    
    

Criação de um produto
    ${CODIGO}    Generate Random String    length=4    chars=[NUMBERS]
    Set Test Variable        ${PRODUTO}        Produto.${CODIGO}
    Log    nome do meu produto: ${PRODUTO}

Cadastrando de produto
    ${Body}    Create Dictionary      nome=${PRODUTO}     preco=320    descricao=Notebook
     ...    quantidade=400
    ${headers}   Create Dictionary  Authorization=${TOKEN}
    ${RETORNO}    POST On Session    alias=ServeRest    url=/produtos     
    ...    json=${Body}    headers=${headers}
    Log    Retorno_Json: ${RETORNO.json()}
    Set Test Variable    ${RETORNOJSON}        ${RETORNO.json()}


Verificar se o produto foi criado
    Log  ${RETORNOJSON}
    Dictionary Should Contain Item    ${RESPOSTAJSON}    message     Cadastro realizado com sucesso
    Dictionary Should Contain Key     ${RESPOSTAJSON}    _id