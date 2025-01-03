*** Settings ***
Resource    ../resources/main.robot
Test Setup     Dado que eu acesse o Organo
Test Teardown    Fechar o navegador

*** Test Cases ***
Verificar preenchimento do formulário e criação correta do card
     Dado que eu preencha os campos do formulário
     Quando eu clicar no botão criar card
     Então o card deve estar no time esperado

Verificar criação de múltiplos cards iguais
     Dado que eu preencha os campos do formulário
     Quando eu clicar no botão criar card
     Então deve ser identificado 3 cards no time esperado

Verificar criação de cards de diferentes times
     Dado que eu preencha os campos do formulário
     Quando eu clicar no botão criar card com diferentes times
     Então os cards devem ser identificados em times diferentes     

Verificar preenchimento do formulário com campo 'Nome' vazio
     Dado que eu preencha os campos do formulário menos o campo Nome
     Quando eu clicar no botão criar card
     Então deve ser exibida uma mensagem de campo obrigatório
