*** Settings ***
Documentation    Keywords para teste de API na plataforma ServeRest
Library         RequestsLibrary
Library         FakerLibrary   locale=pt_br

*** Variables ***
${ALIAS}   API_serverest

*** Keywords ***
Cria dados aleatórios do usuário
    ${RANDOM_NOME_FIRST}   FakerLibrary.First Name
    ${RANDOM_NOME_LAST}    FakerLibrary.Last Name
    ${RANDOM_EMAIL}   FakerLibrary.Email
    ${RANDOM_PWD}     FakerLibrary.Password
    VAR    &{USUARIO}    nome=${RANDOM_NOME_FIRST} ${RANDOM_NOME_LAST}  email=${RANDOM_EMAIL}  senha=${RANDOM_PWD}    scope=SUITE

Iniciar sessão na API serverest
    VAR    &{HEADERS}    Content-Type=application/json
    Create Session    alias=${ALIAS}    url=https://serverest.dev   headers=${HEADERS}   disable_warnings=1

Cadastrar usuário de teste
    Cria dados aleatórios do usuário
    VAR    &{BODY}    nome=${USUARIO.nome}   email=${USUARIO.email}   password=${USUARIO.senha}   administrador=true
    ${RESPONSE}  POST On Session     alias=${ALIAS}    url=usuarios    json=${BODY}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}

Obter Token
    VAR    &{BODY}    email=${USUARIO.email}   password=${USUARIO.senha}
    ${RESPONSE}  POST On Session     alias=${ALIAS}    url=login    json=${BODY}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}
    Should Be Equal As Strings   ${RESPONSE.json()}[message]    Login realizado com sucesso
    VAR    ${TOKEN}    ${RESPONSE.json()}[authorization]    scope=SUITE

Cadastrar um produto
    ${RANDOM_PROD}   FakerLibrary.Word
    VAR    ${RANDOM_PROD}    ${RANDOM_PROD}    scope=SUITE
    VAR    &{BODY}    nome=${RANDOM_PROD}   preco=155   descricao=meu produto de teste   quantidade=10
    VAR    &{HEADERS}    Authorization=${TOKEN}
    ${RESPONSE}  POST On Session    alias=${ALIAS}    url=produtos    json=${BODY}  headers=${HEADERS}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}
    Should Be Equal As Strings    ${RESPONSE.json()}[message]    Cadastro realizado com sucesso
    VAR    ${ID_PRODUTO_CADASTRADO}    ${RESPONSE.json()}[_id]    scope=SUITE

Listar o produto cadastrado
    VAR    &{HEADERS}   Authorization=${TOKEN}
    ${RESPONSE}  GET On Session     alias=${ALIAS}    url=produtos/${ID_PRODUTO_CADASTRADO}  headers=${HEADERS}
    Log   Resposta Retornada: ${\n}${RESPONSE.text}
    Should Be Equal As Strings    ${RESPONSE.json()}[nome]        ${RANDOM_PROD}
    Should Be Equal As Integers    ${RESPONSE.json()}[preco]    155
    Should Be Equal As Strings    ${RESPONSE.json()}[descricao]   meu produto de teste
    Should Be Equal As Integers    ${RESPONSE.json()}[quantidade]    10
    Should Not Be Empty     ${RESPONSE.json()}[_id]