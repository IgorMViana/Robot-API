*** Settings ***
Documentation    Keywords para teste de API na plataforma ServeRest
Library         FakerLibrary   locale=pt_br
Library         JsonValidator
Library         RequestsLibrary

*** Variables ***
${ALIAS}    API_serverest
&{USUARIO_BASE}    nome=base_user_01  email=baseUser@teste.com  password=senhaBase123    administrador=true
${USUARIO_BASE_ID}

*** Keywords ***
Criar usuario base
    [Documentation]    Cria usuario base
    [Setup]    Iniciar sessão na API serverest
    ${RESPONSE}  POST On Session     alias=${ALIAS}    url=usuarios    json=${USUARIO_BASE}
    VAR    ${USUARIO_BASE_ID}    ${RESPONSE.json()}[_id]    scope=suite

Deleta usuario base
    [Documentation]    Deleta usuario base
    ${RESPONSE}  DELETE On Session     alias=${ALIAS}    url=usuarios/${USUARIO_BASE_ID}

Cria dados aleatórios do usuário
    [Documentation]    Cria dados aleatórios para um usuário utilizando a biblioteca Faker
    ${RANDOM_NOME_FIRST}   FakerLibrary.First Name
    ${RANDOM_NOME_LAST}    FakerLibrary.Last Name
    ${RANDOM_EMAIL}   FakerLibrary.Email
    ${RANDOM_PWD}     FakerLibrary.Password

Iniciar sessão na API serverest
    VAR    &{HEADERS}    Content-Type=application/json
    Create Session    alias=${ALIAS}    url=https://serverest.dev   headers=${HEADERS}   disable_warnings=1
    Session Exists    ${ALIAS}