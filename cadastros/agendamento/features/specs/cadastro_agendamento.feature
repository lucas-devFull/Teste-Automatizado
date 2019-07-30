#language: pt

Funcionalidade: Cadastrar, Editar e Excluir um agendamento

Contexto: Login no sistema e entrada da pagin
Dado a realizacao do login e a entrada na pagina de agendamento

@teste_botao_novo
Cenario: Testar botao de novo
Quando eu clico no botão de novo
Entao devo ser redirecionado ao formulario de cadastro de agendamento

@testes_inputs
Cenario: Testar validações das inputs
Quando eu clico no botão de novo
Entao clico no botão Salvar
Entao deve ser exibido pequenos alertas de erros em baixo de cada input

@teste_novo_cancelar
Cenario: testando botao cancelar no formulario de adicionar
Quando eu clico no botão de novo
E clico em cancelar
Entao deve ser exibido o elemento de alerta
E deve ser exibida mensagem de confirmação de cancelamento
E devo clicar no botão 'sim'
E a tela voltará a grid

@teste_novo_cancelar_2
Cenario: testando botao cancelar no formulario de adicionar
Quando eu clico no botão de novo
E clico em cancelar
Entao deve ser exibido o elemento de alerta
E deve ser exibida mensagem de confirmação de cancelamento
E devo clicar no botão 'nao'
E ele ficará no formulario

@cad_agendamento
Esquema do Cenario: Cadastrar um agendamento
Quando eu clico no botão de novo
E incluo <cliente>, <veiculo>, <periodo>, <contato>
E clico no botão Salvar
Então deve ser exibido o elemento de alerta
E deve ser exibida mensagem de sucesso
Então deve buscar o registro cadastrado na grid

Exemplos:
|cliente        |          veiculo        | periodo|contato    |
|"ANAA"         |"Gs 500 Edson - GES-5578"|"D"     |["ANA"]    |
|"ANAA"         |"Gol G3 Rafa - ANACELL"  |"D"     |["Daniele"]|

@excluir_agendamento
Cenario: Exclusão do agendamento
Quando eu busco e seleciono o registro na grid
E clicar no botão Excluir
Entao deve ser exibido o elemento de alerta
E deve ser exibida mensagem de sucesso
E o registro nao estará na grid

@editar_agendamento
Cenario: Edição do agendamento
Quando eu busco e seleciono o registro na grid
E clico no botão Editar
Então edito "rafael lopes", "gol2 - placa978", "D","ANAA","Daniele"
E clico no botão Salvar
Então deve ser exibido o elemento de alerta 
E deve ser exibida mensagem de sucesso
Então deve buscar o registro editado na grid

@exportacao
Cenario: Exportar os registro da grid
Quando eu clico em Selecione 
E clico em microsoft excel
Entao uma nova aba irá abrir e baixar a exportação