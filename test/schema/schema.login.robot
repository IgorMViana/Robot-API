*** Settings ***
Documentation   Testes de schema do endpoint de login (ServeRestAPI)
Resource    ../../resource/base.resource
Suite Setup    Criar usuario base
Suite Teardown    Deleta usuario base
Test Template    Validar schemas para cada tipo de retorno no login

*** Variables ***
${SUCCESSFUL_LOGIN}    ./schema/login/successful_login.json
${BLANK_LOGIN}    ./schema/login/blank_login.json
${FAILED_LOGIN}    ./schema/login/failed_login.json


*** Test Cases ***        EMAIL                    PASSWORD                    SCHEMA
Login com sucesso         ${USUARIO_BASE.email}    ${USUARIO_BASE.password}    ${SUCCESSFUL_LOGIN}
Login em branco           ${EMPTY}                 ${EMPTY}                    ${BLANK_LOGIN}
Login inválido            ${USUARIO_BASE.email}    aasaasaassa                 ${FAILED_LOGIN}
    



*** Keywords ***
Validar schemas para cada tipo de retorno no login
    [Arguments]    ${email}    ${password}    ${schema}
    VAR    &{LOGIN}    email=${email}    password=${password}
    ${RESPONSE}  POST On Session     alias=${ALIAS}    url=login    json=${LOGIN}    expected_status=any
    Validate Jsonschema From File   ${RESPONSE.json()}    ${schema}
    