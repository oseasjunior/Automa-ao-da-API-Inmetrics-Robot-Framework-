***Settings***
Documentation   Testes na API da Inmetrics
Resource        ../resources/base.robot

***Test Cases***
Cenario: Lista todos os funcionarios (GET)
    Dado que eu esteja logado 
    Quando eu chamo o endpoint da inmetrics
    Então eu espero o status code   200 

Cenario: Cadastro de funcionarios (POST)
    Dado que eu esteja logado
    Quando eu preparar um body
    Então valido o retorno do cadastro

Cenario: Lista de funcionario pelo ID (GET)
    Dado que eu esteja logado 
    Quando eu fizer uma busca por ID
    Então eu espero o retorno deste funcionario

Cenario: Alterando um funcionario (PUT) 
    Dado que eu esteja logado 
    Quando eu alterar um funcionario 
    Então eu valido este funcionario alterado

Cenario: Deletando um funcionario (DELETE)
    Dado que eu esteja logado 
    Quando eu fizer um delete em um funcionario
    Então eu espero que o funcionario seja deletado


