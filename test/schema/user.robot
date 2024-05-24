*** Settings ***
Documentation   Testes utilizando as novas keywords da RequestsLibrary na versão 8
Resource    ../../resources/user.resource
Suite Setup    Criar usuario    true


*** Test Cases ***
Teste de Usuario
    Iniciar sessão na API serverest
    Login
    Login    email=${USUARIO.email}
    Login    password=${USUARIO.password}