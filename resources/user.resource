*** Settings ***
Documentation    Keywords para teste de API na plataforma ServeRest
Resource         base.resource


*** Keywords ***
Login
    [Documentation]    Cria usuario comum ou administrador
    [Arguments]    ${email}=${EMPTY}    ${password}=${EMPTY}
    VAR    &{LOGIN}    email=${email}    password=${password}
    Log To Console    ${LOGIN}
    ${RESPONSE}  POST On Session     alias=${ALIAS}    url=login    json=${LOGIN}    expected_status=any
    Log To Console    ${RESPONSE.json()}
    Validate Jsonschema From File    ${RESPONSE.json()}    ./schema/login/login.json
    