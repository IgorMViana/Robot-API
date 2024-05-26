*** Settings ***
Documentation   Testes de schema do endpoint de login (ServeRestAPI)
Resource    ../../resource/user.resource
Suite Setup    Iniciar sessão na API serverest

*** Variables ***
${USER_GET}    ./schema/user/user.get.json


*** Test Cases ***
Validar schema de listagem de usuarios
    ${JSON}    Listar usuarios    administrador=false    password=123456
    Validate Jsonschema From File    ${JSON}    ${USER_GET}
