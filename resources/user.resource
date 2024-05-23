*** Settings ***
Documentation    Keywords para teste de API na plataforma ServeRest
Resource         base.resource


*** Keywords ***
Criar usuario
    [Documentation]    Cria usuario comum ou administrador
    [Arguments]    ${adm}=false
    ${USUARIO.administrador}    Set Variable    ${adm}
    ${RESPONSE}  POST On Session     alias=${ALIAS}    url=usuarios    json=${USUARIO}
    Validate Jsonschema From File    ${RESPONSE.json()}    ./schema/user/userResponse.json