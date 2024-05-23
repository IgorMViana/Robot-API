*** Settings ***
Documentation   Testes utilizando as novas keywords da RequestsLibrary na versão 8
Resource    ../../resources/user.resource
Suite Setup    Cria dados aleatórios do usuário


*** Test Cases ***
Teste de Usuario
    Iniciar sessão na API serverest
    Criar usuario    true

