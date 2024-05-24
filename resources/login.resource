*** Settings ***
Documentation    Keywords para teste de API na plataforma ServeRest
Resource         base.resource

*** Variables ***
${BLANK_LOGIN}
${FAILED_LOGIN}

*** Keywords ***
Login
    [Documentation]    Loga com um usuário e valida o retorno
    [Arguments]    ${email}=${EMPTY}    ${password}=${EMPTY}
    VAR    &{LOGIN}    email=${email}    password=${password}
    ${RESPONSE}  POST On Session     alias=${ALIAS}    url=login    json=${LOGIN}    expected_status=any
    RETURN    ${RESPONSE.json()}
    
Validate login schema
    [Arguments]    ${JSON}    ${SCHEMA}
    Validate Jsonschema From File    ${JSON}    ${SCHEMA}
    
Login em branco
    [Arguments]    ${email}    ${password}
    ${JSON}    Login    ${email}    ${password}
    Validate Jsonschema From File    ${JSON}    ${BLANK_LOGIN}

Login invalido
    [Arguments]    ${email}
    ${JSON}    Login    ${email}    123456
    Validate Jsonschema From File    ${JSON}    ${FAILED_LOGIN}