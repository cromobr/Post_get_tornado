*** Settings ***
Documentation       A resource file with reusable keywords and variables.
...                 The system specific keywords created here form our own
...                 domain specific language. They utilize keywords provided
...                 by the imported SeleniumLibrary.
Library             SeleniumLibrary
Library             DebugLibrary
Library             RequestsLibrary
Library             Collections


*** Variables ***
${HOST}                     http://localhost:8888/content

*** Keywords ***

#1. Cenario: Enviar nome do arquivo e texto para API (POST)
Dado que chame a API para postar arquivo e conteudo valido
    Create Session          Enviar_POST    ${HOST}     disable_warnings=1


Quando informar nome do arquivo "${arquivo}" e conteudo "${conteudo}"
    ${RETORNO_POST}=        Post Request      Enviar_POST  ${arquivo}  data=${conteudo}

    Log                 Resposta: ${RETORNO_POST.text}
    Set Test Variable       ${RETORNO_POST}

Entao é apresentado mensagem "${mensagem}"
    Should Be Equal As Strings   ${RETORNO_POST.text}     ${mensagem}
    Log             Status Code Retornado: ${RETORNO_POST.text} -- Status Code Esperado: ${mensagem}

#2. Cenario: Enviar nome do arquivo e conteudo em branco para API (POST)
Dado que chame a API para postar arquivo e conteudo em branco
    Create Session          Enviar_POST    ${HOST}     disable_warnings=1

Quando informar nome do arquivo "${arquivo}" e conteudo "${conteudo}" em branco
    ${RETORNO_POST}=        Post Request      Enviar_POST  ${arquivo}

    Log                 Resposta: ${RETORNO_POST.text}
    Set Test Variable       ${RETORNO_POST}

Entao é apresentado mensagem "${mensagem}" para conteudo em branco
    Should Be Equal As Strings   ${RETORNO_POST.text}     ${mensagem}
    Log             Retornado: ${RETORNO_POST.text} -- Esperado: ${mensagem}


#3. Cenario: Ler arquivo com o conteudo (GET)
Dado que chame a API para ler arquivo "${arquivo}" com conteudo "${conteudo}"
    Create Session    Enviar_POST    ${HOST}    disable_warnings=1
    Post Request      Enviar_POST  ${arquivo}   data=${conteudo}

    Create Session          Receber_GET    ${HOST}     disable_warnings=1

Quando informar nome do aquivo "${arquivo}"
    ${RETORNO_GET}=        Get Request      Receber_GET  ${arquivo}

    Log                 Resposta: ${RETORNO_GET.text}
    Set Test Variable       ${RETORNO_GET}

Entao é apresentado mensagem com o conteudo "${conteudo}"
    Should Be Equal As Strings   ${RETORNO_GET.text}     ${conteudo}
    Log             Retornado: ${RETORNO_GET.text} -- Esperado: ${conteudo}

#4. Cenario: Ler arquivo inexistente (GET)
Dado que chame a API para ler aquivo inexistente
    Create Session          Receber_GET    ${HOST}     disable_warnings=1

Quando informar nome do aquivo "${arquivo}" que nao existe
    ${RETORNO_GET}=        Get Request      Receber_GET  ${arquivo}

    Log                 Resposta: ${RETORNO_GET.text}
    Set Test Variable       ${RETORNO_GET}

Entao é apresentado mensagem "${mensagem}" dizendo que o arquivo nao existe
    Should Be Equal As Strings   ${RETORNO_GET.text}     ${mensagem}
    Log             Retornado: ${RETORNO_GET.text} -- Esperado: ${mensagem}