# language: pt

Funcionalidade: Primeiro teste 

Contexto: Fazer login no sistema
    Dado o login no sistema
    E a entrada na pagina

@teste_botao_novo
Cenario: Teste botão adicionar
    Quando clico em adicionar
    Entao a pagina é redirecionada para o formulario de cadastro

@teste_botao_cancelar
Cenario: Teste botão cancelar cadastro
    Quando clico em adicionar
    E a pagina é redirecionada para o formulario de cadastro
    Entao clico em cancelar
    E a pagina retorna para a grid

@teste_botao_editar
Cenario: Teste botão editar
    Quando clico em editar 
    Entao deve aparecer o elemento de alerta
    E deve aparecer a mensagem de alerta

@teste_botao_excluir
Cenario: Teste botão excluir
    Quando clico em excluir 
    Entao deve aparecer o elemento de alerta
    E deve aparecer a mensagem de alerta

@teste_exportação
Cenario: Teste exportação
    Quando eu clico na caixa de seleção de exportação
    E seleciono o tipo de exportação
    Entao abrirá uma nova aba 
    E o download será vericado e redirecionado até a pagina downloads

@teste_cadastro_cliente
Cenario: Teste de input obrigatória
    Quando clico em adicionar
    E clico em salvar
    Entao o campo Nome Fantasia estará vermelho
    E deve aparecer o elemento de alerta
    E deve aparecer a mensagem de alerta

@input_obg_cadastro_cliente
Cenario: Teste cadastrar com input obrigatória
    Quando clico em adicionar
    E inisiro as inputs obrigatórias "Teste Auth"
    Entao clico em salvar
    E deve aparecer o elemento de alerta
    E deve aparecer a mensagem de sucesso

@input_obg_cadastro_cliente
Cenario: Verifica na grid o ultimo  cadastrado
    Quando pesquiso o cliente 'Teste Auth'
    Entao verifico se o registro aparece na grid

@input_obg_cadastro_cliente
Cenario: Enviar convite sem um email cadastrado
    Quando pesquiso o cliente 'Teste Auth'
    E clico em enviar convite
    Entao deve aparecer o elemento de alerta
    E deve aparecer a mensagem de alerta

# @apagar_registros
# Cenario: Apagar todos os registros selecionados da Grid
#     Quando pesquiso o cliente 'Teste Dados Pessoais'
#     Entao Apago todos os registros referentes a ele

# @cadastro_cliente
# Cenario: Cadastro de cliente somente com os dados pessoais
#     Quando clico em adicionar 
#     E a pagina é redirecionada para o formulario de cadastro
#     E inisiro os campos de dados pessoais
#     Entao clico em salvar
#     E deve aparecer o elemento de alerta
#     E deve aparecer a mensagem de sucesso
#     Entao deve aparecer o elemento de alerta
#     E deve aparecer a mensagem de alerta
  
# @cadastro_cliente
# Cenario: Verificar na grid 
#     Quando pesquiso o cliente 'Teste Automatico'
#     Entao verifico se o registro aparece na grid

# @cadastro_cliente
# Cenario:  Verificar selects nas telas
    # Quando pesquiso o cliente 'Teste Automatico'
    # E verifico nas selects se o cliente aparece lá

@cadastro_cliente_contatos
Cenario: Cadastro de cliente teste na parte de Contatos sem colocar nome fantasia
    Quando clico em adicionar
    E clico na parte contatos
    E adiciono a 'Test Contatos', 'lucaslssouza2015@gmail.com', '55', '146526521651'
    E clico em adicionar contato 
    Entao clico em salvar
    Entao deve aparecer o elemento de alerta
    E deve aparecer a mensagem de alerta

@cadastro_cliente_contatos
Cenario: Verificar na grid 
    Entao verifico se o registro nao aparece na grid

# @cadastro_cliente_contatos_web
# Cenario: Cadastro cliente Contato verificar na web
#     Quando clico em adicionar
#     E adiciono o nome fantasia "teste Contato"
#     E clico na parte contatos
#     E adiciono a 'Test desc Contato Web', 'lucas_souza@gmail.com', '55', '189758714568'
#     E clico em adicionar contato
#     Entao clico em salvar
#     Entao deve aparecer o elemento de alerta
#     E deve aparecer a mensagem de sucesso

@cadastro_cliente_contatos_web
Cenario: Verificar cadastro cliente parte contato 
    Quando pesquiso o cliente 'teste Contato'
    Entao verifico se o registro aparece na grid
    E entro na tela de contato
    E verifico se as informaçõs batem

@cadastro_cliente_contatos_web
Cenario: Verificar cadastro cliente parte contato no alerta
    Quando clico no icone do alerta
    E seleciono o ultimo alerta
    Entao eu finalizo o chamado e verifico se as informações de contato batem


# editar o liberado para não 
# @teste_fmobile
# Cenario: Bloquear usuario F/mobile
    # Quando pesquiso o cliente 'Teste Automatico'
    # E clico em editar
    # E mudo o selecionado de SIM para NÃO 
    # E clico em salvar
    # E deve aparecer o elemento de alerta
    # E deve aparecer a mensagem de sucesso
    # Entao nao poderei ver os veiculos do cliente escolhido

# Comparar Relatorios 
# @comparar_trajeto_percorrido
# Cenario: Comparar Relatórios 
    # Quando pesquiso o cliente 'Teste Automatico'
    # E entro na tela de relatorios de trajeto percorrido
    # E seleciono o cliente
    # E seleciono o veiculo
    # E seleciono a data inicial '23/08/2019' e a data final '23/09/2019'
    # E seleciono o horario inicial '12:00' e o horario final '15:00'
    # Entao clico em gerar relatorio
    # E verifico os resultados gerados
    # Entao entro no app 
    # E seleciono um cliente
    # E entro na tela de trajeto percorrido 
    # E seleciono data e horario especifico
    # E comparo os resultados gerados com a da web