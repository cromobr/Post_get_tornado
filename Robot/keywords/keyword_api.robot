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

${NOME_ARQUIVO_EXISTENTE}               ListaContato
${NOME_ARQUIVO_INEXISTENTE}               ContatoLista
${CONTEUDO_VALIDO}             Bruno (19)9-99999999
${CONTEUDO_INVALIDO}
${HOST}                     http://localhost:8888/content
${MENSAGEM_NOME_CONTEUDO_VALIDO}    Arquivo criado com suscesso
${MENSAGEM_NOME_CONTEUDO_INVALIDO}    Sem valores no post da mensagem
${MENSAGEM_CONTEUDO_VALIDO}    Bruno (19)9-99999999
${MENSAGEM_NOME_CONTEUDO_VALIDO}    Arquivo criado com suscesso
${MENSAGEM_ARQUIVO_INEXISTENTE}    Arquivo não existe


*** Keywords ***

#1. Cenario: Enviar nome do arquivo (ListaContato) e texto (Bruno 19 9999-9999) para API (POST)
Dado que chame a API para postar arquivo e conteudo
    Create Session          Enviar_POST    ${HOST}     disable_warnings=1


Qaundo informar nome do aquivo "ListaContato" e conteudo "Bruno 19 9999-9999"
    ${RETORNO_POST}=        Post Request      Enviar_POST  ${NOME_ARQUIVO_EXISTENTE}  data=${CONTEUDO_VALIDO}

    Log                 Resposta: ${RETORNO_POST.text}
    Set Test Variable       ${RETORNO_POST}

Entao é apresentado mensagem "Arquivo criado com suscesso"
    Should Be Equal As Strings   ${RETORNO_POST.text}     ${MENSAGEM_NOME_CONTEUDO_VALIDO}
    Log             Status Code Retornado: ${RETORNO_POST.text} -- Status Code Esperado: ${MENSAGEM_NOME_CONTEUDO_VALIDO}



#2. Cenario: Enviar nome do arquivo (ListaContato) e texto em branco para API (POST)
Dado que chame a API para postar conteudo em branco
    Create Session          Enviar_POST    ${HOST}     disable_warnings=1

Qaundo informar nome do aquivo "ListaContato" e conteuno ""
    ${RETORNO_POST}=        Post Request      Enviar_POST  ${NOME_ARQUIVO_EXISTENTE}

    Log                 Resposta: ${RETORNO_POST.text}
    Set Test Variable       ${RETORNO_POST}

Entao é apresentado mensagem "Sem valores no post da mensagem"
    Should Be Equal As Strings   ${RETORNO_POST.text}     ${MENSAGEM_NOME_CONTEUDO_INVALIDO}
    Log             Retornado: ${RETORNO_POST.text} -- Esperado: ${MENSAGEM_NOME_CONTEUDO_INVALIDO}


#3. Cenario: Ler arquivo (ListaContato) com o conteudo (Bruno 19 9999-9999) (GET)
Dado que chame a API para ler arquivo existente
    Create Session          Receber_GET    ${HOST}     disable_warnings=1

Qaundo informar nome do aquivo "ListaContato"
    ${RETORNO_GET}=        Get Request      Receber_GET  ${NOME_ARQUIVO_EXISTENTE}

    Log                 Resposta: ${RETORNO_GET.text}
    Set Test Variable       ${RETORNO_GET}

Entao é apresentado mensagem com o conteudo "Bruno 19 9999-9999"
    Should Be Equal As Strings   ${RETORNO_GET.text}     ${MENSAGEM_CONTEUDO_VALIDO}
    Log             Retornado: ${RETORNO_GET.text} -- Esperado: ${MENSAGEM_CONTEUDO_VALIDO}

#4. Cenario: Ler arquivo inexistente (GET)
Dado que chame a API para ler aquivo inexistente
    Create Session          Receber_GET    ${HOST}     disable_warnings=1

Qaundo informar nome do aquivo "ContatoLista"
    ${RETORNO_GET}=        Get Request      Receber_GET  ${NOME_ARQUIVO_INEXISTENTE}

    Log                 Resposta: ${RETORNO_GET.text}
    Set Test Variable       ${RETORNO_GET}

Entao é apresentado mensagem "Arquivo não existe"
    Should Be Equal As Strings   ${RETORNO_GET.text}     ${MENSAGEM_ARQUIVO_INEXISTENTE}
    Log             Retornado: ${RETORNO_GET.text} -- Esperado: ${MENSAGEM_ARQUIVO_INEXISTENTE}