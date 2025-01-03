*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${URL}                    http://localhost:3000/

*** Keywords ***
Dado que eu acesse o Organo
    Open Browser    url=${URL}    browser=Chrome

Fechar o navegador
    Close Browser