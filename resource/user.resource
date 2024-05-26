*** Settings ***
Documentation    Keywords para teste de API na plataforma ServeRest
Resource         base.resource

*** Variables ***
${BLANK_LOGIN}
${FAILED_LOGIN}

*** Keywords ***
Listar usuarios
    [Documentation]    Lista usuarios cadastrados
    [Arguments]    ${_id}=${EMPTY}    ${nome}=${EMPTY}    ${email}=${EMPTY}    ${password}=${EMPTY}    ${administrador}=${EMPTY}
    VAR    &{query}    _id=${_id}    nome=${nome}    password=${password}    administrador=${administrador}
    ${query,email}    Set Variable If    '${email}' != '${EMPTY}'    ${email}
    ${RESPONSE}  GET On Session     alias=${ALIAS}    url=usuarios    expected_status=any    params=${query}
    Log To Console    ${RESPONSE.json()}
    RETURN    ${RESPONSE.json()}

Validate GET schema
    [Arguments]    ${JSON}    ${SCHEMA}
    Validate Jsonschema From File    ${JSON}    ${SCHEMA}