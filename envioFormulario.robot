*** Settings ***
Library    SeleniumLibrary
Library    FakerLibrary
Library    XML
Resource    setup_teardown.robot
Test Setup    Dado que eu acesse o Organo
Test Teardown    Fechar o navegador

*** Variables ***
${URL}                    http://localhost:3000/
${CAMPO_NOME}             id:form-nome
${CAMPO_CARGO}            id:form-cargo
${CAMPO_IMAGEM}           id:form-imagem
${CAMPO_TIME}             class:lista-suspensa
${BOTAO_CARD}             id:form-botao
@{selecionar_times}
...       //option[contains(.,'Programação')]
...       //option[contains(.,'Front-End')]
...       //option[contains(.,'Data Science')]
...       //option[contains(.,'Devops')]
...       //option[contains(.,'UX e Design')]
...       //option[contains(.,'Mobile')]
...       //option[contains(.,'Inovação')]
${CONFIRMA_CARD}          class:colaborador

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

*** Keywords ***

Dado que eu acesse o Organo
    Open Browser    url=${URL}    browser=Chrome

Dado que eu preencha os campos do formulário
    ${Nome}    FakerLibrary.First Name
    ${Cargo}    FakerLibrary.Job
    ${Imagem}    FakerLibrary.Image Url
    Input Text       ${CAMPO_NOME}       ${Nome}
    Input Text       ${CAMPO_CARGO}      ${Cargo} 
    Input Text       ${CAMPO_IMAGEM}     ${Imagem}
    Click Element    ${CAMPO_TIME}
    Click Element    ${selecionar_times}[0]

Dado que eu preencha os campos do formulário menos o campo Nome
    Input Text       ${CAMPO_CARGO}      QA 
    Input Text       ${CAMPO_IMAGEM}     https://picsum.photos/200/300
    Click Element    ${CAMPO_TIME}
    Click Element    ${selecionar_times}[0]

Quando eu clicar no botão criar card    
    Click Element    ${BOTAO_CARD}

Então o card deve estar no time esperado
    Element Should Be Visible    ${CONFIRMA_CARD}

Então deve ser exibida uma mensagem de campo obrigatório
    Element Text Should Be    form-nome-erro    O campo nome deve ser preenchido

Então deve ser identificado 3 cards no time esperado
    FOR    ${i}    IN RANGE    1    3
        Dado que eu preencha os campos do formulário
        Quando eu clicar no botão criar card    
        Então o card deve estar no time esperado
    END

Quando eu clicar no botão criar card com diferentes times
    FOR    ${i}    ${time}    IN ENUMERATE    @{selecionar_times}
        Dado que eu preencha os campos do formulário
        Click Element    ${time}
        Quando eu clicar no botão criar card
    END
Então os cards devem ser identificados em times diferentes     
    Element Should Be Visible    //*[@id="root"]/div/section[2]/div
    Element Should Be Visible    //*[@id="root"]/div/section[3]/div
    Element Should Be Visible    //*[@id="root"]/div/section[4]/div
    Element Should Be Visible    //*[@id="root"]/div/section[5]/div
    Element Should Be Visible    //*[@id="root"]/div/section[6]/div
    Element Should Be Visible    //*[@id="root"]/div/section[7]/div
    Element Should Be Visible    //*[@id="root"]/div/section[8]/div
