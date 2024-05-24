*** Settings ***
Documentation   Testes de schema do endpoint de login (ServeRestAPI)
Resource    ../../resources/login.resource
Suite Setup    Criar usuario base
Suite Teardown    Deleta usuario base

*** Variables ***
${SUCCESSFUL_LOGIN}    ./schema/login/successful_login.json
${BLANK_LOGIN}    ./schema/login/blank_login.json
${FAILED_LOGIN}    ./schema/login/failed_login.json


*** Test Cases ***
Validar schema de sucesso do endpoint Login
    ${JSON}    Login    ${USUARIO_BASE.email}    ${USUARIO_BASE.password}
    Validate login schema    ${JSON}    ${SUCCESSFUL_LOGIN}

Validar schema de Login com campos em branco
    [Template]    Login em branco 
    email=${EMPTY}    password=${EMPTY}    
    email=${USUARIO_BASE.email}    password=${EMPTY}
    email=${EMPTY}    password=${USUARIO_BASE.password}

Validar login inválido
    [Template]    Login invalido
    ${USUARIO_BASE.email}
    emailInvalido@teste.com