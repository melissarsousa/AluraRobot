*** Settings ***
Library    SeleniumLibrary
Library    XML

*** Variables ***
*** Variables ***
${URL}                    http://localhost:3000/
${CAMPO_NOME}             id:form-nome
${CAMPO_CARGO}            id:form-cargo
${CAMPO_IMAGEM}           id:form-imagem
${CAMPO_TIME}             class:lista-suspensa
${BOTAO_CARD}             id:form-botao
${OPCAO_PROGRAMACAO}      //option[contains(.,'Programação')]
${CONFIRMA_CARD}          class:colaborador

*** Test Cases ***
Verificar preenchimento do formulário e criação correta do card
     Dado que eu acesse o Organo
     E preencha os campos do formulário
     Quando eu clicar no botão criar card
     Então identificar o card no time esperado

*** Keywords ***

Dado que eu acesse o Organo
    Open Browser    url=${URL}    browser=Chrome

E preencha os campos do formulário
    Input Text       ${CAMPO_NOME}       Akemi
    Input Text       ${CAMPO_CARGO}      Desenvolvedora 
    Input Text       ${CAMPO_IMAGEM}     https://picsum.photos/200/300
    Click Element    ${CAMPO_TIME}
    Click Element    ${OPCAO_PROGRAMACAO}

Quando eu clicar no botão criar card    
    Click Element    ${BOTAO_CARD}

Então identificar o card no time esperado
    Element Should Be Visible    ${CONFIRMA_CARD}