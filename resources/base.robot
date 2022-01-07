*** Settings ***
Documentation   Base para todos os testes da API
Library               RequestsLibrary
Library               Collections

***Variables***
${BASE_URL_API}         https://inm-api-test.herokuapp.com/empregado
${user}                 inmetrics
${password}             automacao
${FUNCIONARIO_BODY}     {
...                         "nome": "jaison",
...                         "sexo": "m",
...                         "cpf": "065.874.598-71",
...                         "departamentoId": "1",
...                         "cargo": "Desenvolvedor de Automacao",
...                         "admissao": "07/02/1998",
...                         "salario": "1.000,00",
...                         "comissao": "3.000,00",
...                         "tipoContratacao": "clt"
...                                                 }

${FUNCIONARIO_BODY_ALTERAR}     {
...                         "nome": "oseas",
...                         "sexo": "m",
...                         "cpf": "065.874.598-71",
...                         "departamentoId": "1",
...                         "cargo": "Desenvolvedor de Automacao",
...                         "admissao": "07/02/1998",
...                         "salario": "1.000,00",
...                         "comissao": "3.000,00",
...                         "tipoContratacao": "clt"
...                                                 }


***Keywords***
Dado que eu esteja logado 
    ${AUTH}=            create list     ${user}               ${password}
    Create Session      APIInmetrics    ${BASE_URL_API}       auth=${AUTH}
    Set Test Variable   ${AUTH}     

#GET all
Quando eu chamo o endpoint da inmetrics
    ${RESPOSTA_GET}   GET On Session        APIInmetrics        ${BASE_URL_API}/list_all
    Set Test Variable    ${RESPOSTA_GET}


Então eu espero o status code
     [Arguments]                        ${STATUSCODE_DESEJADO}
   Should Be Equal As Strings           ${RESPOSTA_GET.status_code}   ${STATUSCODE_DESEJADO}

Quando eu preparar um body
   ${HEADERS}           Create Dictionary           content-type=application/json      
   ${RESPOSTA_POST}     POST On Session             APIInmetrics    ${BASE_URL_API}/cadastrar
   ...                  data=${FUNCIONARIO_BODY}    
   ...                  headers=${HEADERS}
   Set Suite Variable    ${RESPOSTA_POST}
   

Então valido o retorno do cadastro
    Status Should Be    202         ${RESPOSTA_POST}




#GET by ID
Quando eu fizer uma busca por ID
    ${RESPOSTA_GET}   GET On Session        APIInmetrics        ${BASE_URL_API}/list/${RESPOSTA_POST.json()["empregadoId"]}
    Set Test Variable    ${RESPOSTA_GET}

Então eu espero o retorno deste funcionario
        Status Should Be    202         ${RESPOSTA_GET}




#PUT
Quando eu alterar um funcionario 
    ${HEADERS}                  Create Dictionary                   content-type=application/json      
    ${RESPOSTA_PUT}             PUT On Session                      APIInmetrics    ${BASE_URL_API}/alterar/${RESPOSTA_POST.json()["empregadoId"]}
    ...                         data=${FUNCIONARIO_BODY_ALTERAR}    
    ...                         headers=${HEADERS}
    Set Suite Variable          ${RESPOSTA_PUT}
    Log                         ${RESPOSTA_PUT.json()["empregadoId"]}


Então eu valido este funcionario alterado
        Status Should Be    202         ${RESPOSTA_PUT}






#DELETE
Quando eu fizer um delete em um funcionario
    ${RESPOSTA_DELETE}             DELETE On Session     APIInmetrics    ${BASE_URL_API}/deletar/${RESPOSTA_PUT.json()["empregadoId"]}
    Set Test Variable              ${RESPOSTA_DELETE}


Então eu espero que o funcionario seja deletado
            Status Should Be    202         ${RESPOSTA_DELETE}







    

    
