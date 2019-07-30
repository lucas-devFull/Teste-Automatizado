#language: pt

Funcionalidade: Funcionalidade: Testar a tela Configuração F/Cell

- Logar no Fulltrack
- Acessar o menu lateral
- Acessar o Configuração F/Cell
- Cadastrar uma Configuração F/Cell
- Editar e Excluir uma Configuração F/Cell
- Buscar a Configuração F/Cell na grid
- Testar os Botões

Contexto: Quando eu logo no Fulltrack e acesso a pagina de configuração do Fcell
Dado login no sistema
E entrada na página de configuração do Fcell

@testar_botao_novo
Cenário: Selecionando o botão de novo
Quando eu clico no botão de novo
Então devo ir ao formulário de Configuração FCell


@config_fcell
Esquema do Cenário: Inclusão da Configuração F/Cell e botão Salvar
Quando eu clico no botão de novo
E incluo <fcc_descricao>, <fcc_numero_envios_buffer>, <fcc_intervalo_comunicacao_segundos> e seleciono a opção <enable_on_and_off>
E clico no botão Salvar
Então deve ser exibido o elemento de alerta
E deve ser exibida mensagem de sucesso
Então deve buscar o registro cadastrado na grid
E verificar se ele aparece no cadastro de acesso ao selecionar a opcao de busca Fcell

Exemplos:
|fcc_descricao                                                                                                                                                                                                                                                    |fcc_numero_envios_buffer|fcc_intervalo_comunicacao_segundos|enable_on_and_off|
|"Lucas"                                                                                                                                                                                                                                                          |150                     |"5 "                       |1                       |
|"Guilherme"                                                                                                                                                                                                                                                      |200                     |"2 "                       |0                       |
|"aaaaaaaaaaaaaaaaaa/*-+-*/áaá[aaã435435423542!@#$%$#@!xldkcjdokc/;/;.,~aãááããã[a;a;/A:A::A::::aA:mooubnibnaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"|200                     |"2 "                       |1                       |


@botao_excluir
Cenário: Exclusão da Configuração F/Cell
Quando clico no botão Excluir
Então deve ser exibido o elemento de alerta
E ser exibido uma mensagem para escolher um registro

@exclusao_fcell
Cenário: Exclusão da Configuração F/Cell
Quando eu busco e seleciono o registro na grid
E clico no botão Excluir
Então deve ser exibido o elemento de alerta
E deve ser exibida mensagem de confirmação de exclusão
Então devo clicar no botão Sim
Então deve ser exibido o elemento de alerta
E deve ser exibida mensagem de sucesso
Entao verifico se o registro ja saiu da grid
E verifico se ele desapareceu do cadastro de acesso ao selecionar a opcao de busca Fcell

@botao_editar
Cenário: Teste do botão editar
Quando clico no botão Editar
Então ser exibido uma mensagem para escolher um registro

@edicao_fcell
Cenário: Edição da Configuração F/Cell e botão Salvar
Quando eu busco e seleciono o registro na grid
E clico no botão Editar
Então edito 'CONSAA', '200','2 ',1
E clico no botão Salvar
Então deve ser exibido o elemento de alerta
E deve ser exibida mensagem de sucesso
Então deve buscar o registro alterado na grid
E verificar se ele tambem foi alterado na opcao de busca Fcell

