*** Settings ***
Documentation    Keywords para teste de API na plataforma ServeRest
Resource         base.resource
Library        String

*** Variables ***
${BLANK_LOGIN}
${FAILED_LOGIN}
${USER}

*** Keywords ***
Listar usuarios
    [Documentation]    Lista usuarios cadastrados
    [Arguments]    ${_id}=${EMPTY}    ${nome}=${EMPTY}    ${email}=${EMPTY}    ${password}=${EMPTY}    ${administrador}=${EMPTY}
    VAR    &{query}    _id=${_id}    nome=${nome}    password=${password}    administrador=${administrador}
    ${query,email}    Set Variable If    '${email}' != '${EMPTY}'    ${email}
    ${RESPONSE}  GET On Session     alias=${ALIAS}    url=usuarios    expected_status=any    params=${query}
    RETURN    ${RESPONSE.json()}

Cria dados aleatórios do usuário
    [Documentation]    Cria dados aleatórios para um usuário utilizando a biblioteca Faker
    ${ADM}                 FakerLibrary.Boolean
    ${ADM}    Convert To String      ${ADM}
    ${ADM}    Convert To Lower Case    ${ADM}
    ${RANDOM_PWD}          FakerLibrary.Password
    ${RANDOM_EMAIL}        FakerLibrary.Email
    ${RANDOM_NOME_LAST}    FakerLibrary.Last Name
    ${RANDOM_NOME_FIRST}   FakerLibrary.First Name
    VAR    &{USER}    nome=${RANDOM_NOME_FIRST} ${RANDOM_NOME_LAST}    email=${RANDOM_EMAIL}
    ...    password=${RANDOM_PWD}    administrador=${ADM}    scope=test

Cria usuario e retorna
    ${RESPONSE}  POST On Session     alias=${ALIAS}    url=usuarios    json=${USER}    expected_status=created
    RETURN    ${RESPONSE.json()}

Deleta usuario criado
    [Arguments]    ${ID}
    DELETE On Session    alias=${ALIAS}    url=usuarios/${ID}