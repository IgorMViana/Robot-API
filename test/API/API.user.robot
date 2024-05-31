*** Settings ***
Documentation   Testes de schema do endpoint de login (ServeRestAPI)
Resource    ../../resource/user.resource
Suite Setup    Iniciar sessão na API serverest

*** Variables ***
${RESPONSE}

*** Test Cases ***
Validar criacao de usuario com sucesso
    [Setup]    Cria dados aleatórios do usuário
    [Teardown]    Deleta usuario criado    ${RESPONSE}[_id]
    ${RESPONSE}    Cria usuario e retorna
    Should Be Equal    ${RESPONSE}[message]    Cadastro realizado com sucesso
    Should Match Regexp    ${RESPONSE}[_id]    \\w{16}
    










    #criar usuario
    #listar usuario passando o usuario que criei por parametro
    #buscar usuario por ID
    #editar usuario
    #deletar usuario