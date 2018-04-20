*** Settings ***
Documentation  Acesso a API python com tornado
Resource  ../keywords/keyword-api-refactor.robot

*** Test Cases ***
1. Cenario: Enviar nome do arquivo e texto para API (POST)
    [Tags]  post_aquivo_conteudo_valido
    Dado que chame a API para postar arquivo e conteudo valido
    Quando informar nome do arquivo "listaContato" e conteudo "Manuel (19)9-9999-9999"
    Entao é apresentado mensagem "Arquivo criado com suscesso"

2. Cenario: Enviar nome do arquivo e texto em branco para API (POST)
    [Tags]  post_arquivo_valido_conteudo_em_branco
    Dado que chame a API para postar arquivo e conteudo em branco
    Quando informar nome do arquivo "Receita" e conteudo "" em branco
    Entao é apresentado mensagem "Sem valores no post da mensagem" para conteudo em branco

3. Cenario: Ler arquivo com o conteudo (GET)
    [Tags]  get_ler_arquivo_existente
    Dado que chame a API para ler arquivo "Saldo" com conteudo "Data 10/10/2018 - Saldo do Dia: R$ 31.525,00"
    Quando informar nome do aquivo "Saldo"
    Entao é apresentado mensagem com o conteudo "Data 10/10/2018 - Saldo do Dia: R$ 31.525,00"

4. Cenario: Ler arquivo inexistente (GET)
    [Tags]  get_ler_arquivo_inexistente
    Dado que chame a API para ler aquivo inexistente
    Quando informar nome do aquivo "Notas" que nao existe
    Entao é apresentado mensagem "Arquivo não existe" dizendo que o arquivo nao existe