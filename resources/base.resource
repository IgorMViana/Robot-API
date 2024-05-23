*** Settings ***
Documentation    Keywords para teste de API na plataforma ServeRest
Resource         base.resource
Library         FakerLibrary   locale=pt_br
Library         JsonValidator
Library         RequestsLibrary

*** Variables ***
${ALIAS}    API_serverest
&{USUARIO}

*** Keywords ***
Cria dados aleatórios do usuário
    [Documentation]    Cria dados aleatórios para um usuário utilizando a biblioteca Faker
    ${RANDOM_NOME_FIRST}   FakerLibrary.First Name
    ${RANDOM_NOME_LAST}    FakerLibrary.Last Name
    ${RANDOM_EMAIL}   FakerLibrary.Email
    ${RANDOM_PWD}     FakerLibrary.Password
    VAR     &{USUARIO}    nome=${RANDOM_NOME_FIRST} ${RANDOM_NOME_LAST}  email=${RANDOM_EMAIL}  password=${RANDOM_PWD}    scope=suite

Iniciar sessão na API serverest
    VAR    &{HEADERS}    Content-Type=application/json
    Create Session    alias=${ALIAS}    url=https://serverest.dev   headers=${HEADERS}   disable_warnings=1
    Session Exists    ${ALIAS}