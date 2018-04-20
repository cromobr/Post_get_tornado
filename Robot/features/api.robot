*** Settings ***
Documentation  Acesso a API python com tornado
Resource  ../keywords/keyword_api.robot


*** Test Cases ***
1. Cenario: Enviar nome do arquivo (ListaContato) e texto (Bruno 19 9999-9999) para API (POST)
    [Tags]  post_aquivo_conteudo_valido
    Dado que chame a API para postar arquivo e conteudo
    Qaundo informar nome do aquivo "ListaContato" e conteudo "Bruno 19 9999-9999"
    Entao é apresentado mensagem "Arquivo criado com suscesso"

2. Cenario: Enviar nome do arquivo (ListaContato) e texto em branco para API (POST)
    [Tags]  post_arquivo_valido_conteudo_em_branco
    Dado que chame a API para postar conteudo em branco
    Qaundo informar nome do aquivo "ListaContato" e conteuno ""
    Entao é apresentado mensagem "Sem valores no post da mensagem"

3. Cenario: Ler arquivo (ListaContato) com o conteudo (Bruno 19 9999-9999) (GET)
    [Tags]  get_ler_arquivo_existente
    Dado que chame a API para ler arquivo existente
    Qaundo informar nome do aquivo "ListaContato"
    Entao é apresentado mensagem com o conteudo "Bruno 19 9999-9999"

4. Cenario: Ler arquivo inexistente (GET)
    [Tags]  get_ler_arquivo_inexistente
    Dado que chame a API para ler aquivo inexistente
    Qaundo informar nome do aquivo "ContatoLista"
    Entao é apresentado mensagem "Arquivo não existe"