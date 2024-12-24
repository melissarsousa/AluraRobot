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
     Então o card deve estar no time esperado

Verificar preenchimento do formulário com campo 'Nome' vazio
     Dado que eu acesse o Organo
     E preencha os campos do formulário menos o campo Nome
     Quando eu clicar no botão criar card
     Então deve ser exibida uma mensagem de campo obrigatório

*** Keywords ***

Dado que eu acesse o Organo
    Open Browser    url=${URL}    browser=Chrome

E preencha os campos do formulário
    Input Text       ${CAMPO_NOME}       Melissa
    Input Text       ${CAMPO_CARGO}      QA 
    Input Text       ${CAMPO_IMAGEM}     https://picsum.photos/200/300
    Click Element    ${CAMPO_TIME}
    Click Element    ${OPCAO_PROGRAMACAO}

E preencha os campos do formulário menos o campo Nome
    Input Text       ${CAMPO_CARGO}      QA 
    Input Text       ${CAMPO_IMAGEM}     https://picsum.photos/200/300
    Click Element    ${CAMPO_TIME}
    Click Element    ${OPCAO_PROGRAMACAO}

Quando eu clicar no botão criar card    
    Click Element    ${BOTAO_CARD}

Então o card deve estar no time esperado
    Element Should Be Visible    ${CONFIRMA_CARD}

Então deve ser exibida uma mensagem de campo obrigatório
    Element Text Should Be    form-nome-erro    O campo nome deve ser preenchido