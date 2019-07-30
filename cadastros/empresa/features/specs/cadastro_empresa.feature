#language: pt

@teste_empresa
Funcionalidade: Cadastrar, Editar e Excluir uma empresa

Contexto: logar no sistema e entrar no cadastro de empresa
Dado login no sistema
E entrada no cadastro de empresa

@teste_botao_novo
Cenario: Testar botao de novo
Quando clico em adicionar
Entao devo ser redirecionado ao formulario de cadastro de empresa

@testes_inputs
Cenario: Testar validações das inputs e campo email
Quando clico em adicionar
E Adiciono os campos ' la','la',' ',' ça','ça ','ça ','la ',' la'
Entao eu clico em salvar
Entao deve ser exibido pequenos alertas de erros em baixo de cada input

@teste_novo_cancelar
Cenario: testando botao cancelar no formulario de adicionar
Quando clico em adicionar
E clico em cancelar
Entao deve ser exibido o elemento de alerta
E deve ser exibida mensagem de confirmação de cancelamento
E devo clicar no botão 'sim'
E a tela voltará a grid

@teste_novo_cancelar_2
Cenario: testando botao cancelar no formulario de adicionar
Quando clico em adicionar
E clico em cancelar
Entao deve ser exibido o elemento de alerta
E deve ser exibida mensagem de confirmação de cancelamento
E devo clicar no botão 'nao'
E ele ficará no formulario

@cad_empresa
Esquema do Cenario: cadastrar uma empresa e verificar se esta cadastrada
Quando clico em adicionar
E Adiciono os campos <razaoSocial>,<nome>,<email>,<endereco>,<bairro>,<país>,<estado>,<cidade>
E eu clico em salvar
Entao deve ser exibido o elemento de alerta
E deve ser exibida mensagem de sucesso
E verifico na grid se ele foi cadastrado
E verifico se ela aparece no acesso do monitoramento

Exemplos:
|razaoSocial                                                                       |nome                                                                              |email                                                                             |endereco                                                                          |bairro                                                                            |país                                                                              |estado                                                                            |cidade                                                                            |
|"TesteFulltime"                                                                   |"FullTestes"                                                                      |"Fulltime.lucasteste@gmail.com"                                                   |"Av. Presidente Vargas,70"                                                        |"Centro"                                                                          |"Braisl"                                                                          |"São Paulo"                                                                       |"Garça"                                                                           |
|"Teste@"                                                                          |"FullTestes2"                                                                     |"Lucas.lucasteste@gmail.com"                                                      |"Av. Presidente Vargas"                                                           |"Centro"                                                                          |"Braisl"                                                                          |"São Paulo"                                                                       |"Garça"                                                                           |
|"````@@#$%*())_+_AAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"|"````@@#$%*())_+_AAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"|"````@@#$%*())_+_AAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"|"````@@#$%*())_+_AAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"|"````@@#$%*())_+_AAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"|"````@@#$%*())_+_AAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"|"````@@#$%*())_+_AAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"|"````@@#$%*())_+_AAAAAAAAAAAAAaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"|

@teste_botao_excluir
Cenario: testar botao excluir, sem selecionar um registro
Quando clicar em excluir
Entao deve ser exibida mensagem de alerta

@excluir_empresa_com_registro
Cenario: Excluir uma empresa com registro
Quando seleciono um registro 'JoonSystem'
E clicar em excluir
Entao deve ser exibida mensagem de alerta com registro

@excluir_empresa
Cenario: excluir uma empresa
Quando seleciono um registro 'Teste@'
E clicar em excluir
E deve ser exibida mensagem de deletado com sucesso
Entao verifico na grid se ele foi apagado
E verifico se ela ainda aparece no acesso do monitoramento


@editar_empresa
Cenario: editar descricao e razao social de uma empresa
Quando seleciono um registro 'Teste@'
E clico em editar
E altero os campos para 'Test$Alterado','Fulltestes3','LcasTesteFulltime@gmail.com','Lá em casa','Céntro$','Brásil#%','Sla','Gárç/ã'
Entao eu clico em salvar
Entao deve ser exibido o elemento de alerta
E deve ser exibida mensagem de alterado com sucesso
E verifico na grid se ele foi alterado
E verifico se a alteração aparece no acesso do monitoramento

@exportacao 
Cenario: Exportar os registro da grid
Quando eu clico em Selecione 
E clico em microsoft excel
Entao uma nova aba irá abrir e baixar a exportação