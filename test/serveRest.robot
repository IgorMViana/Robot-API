*** Settings ***
Documentation   Testes utilizando as novas keywords da RequestsLibrary na versão 8
Resource    ../resources/serveRest.resource


*** Test Cases ***
Testar a API pública de estudos serverest
    Iniciar sessão na API serverest
    Cadastrar usuário de teste
    Obter Token
    Cadastrar um produto
    Listar o produto cadastrado


