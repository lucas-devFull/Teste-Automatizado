#language: pt

Funcionalidade: Testar todas as funções do cadastro de ponto de referencia
    - testar botões
    - testar inputs e obrigatoriedades
    - testar utf8 em inputs e selects 

Contexto: Login no sistema e a entrada na pagina
Dado o login no sitema 

@teste_botao_novo
Cenário: Selecionando o botão de novo
Quando entro na pagina
Quando clico no botão de novo
Então devo ir ao cadastro de Ponto de Referência

@teste_botao_cancelar
Cenario: Quando eu cancelo um cadastro
Quando entro na pagina
Quando clico no botão de novo
E devo ir ao cadastro de Ponto de Referência
Então clico no botão cancelar
E deve ser exibido o elemento de alerta
Então clico em 'sim' 
E retorno para a grid

@teste_botao_cancelar_2
Cenario: Quando eu cancelo um cadastro
Quando entro na pagina
Quando clico no botão de novo
E devo ir ao cadastro de Ponto de Referência
Então clico no botão cancelar
E deve ser exibido o elemento de alerta
Então clico em 'nao' 
E ele continua no formulário

@campos_obg
Cenario: Teste campos obrigatórios
Quando entro na pagina
Quando clico no botão de novo
E clico em Salvar
Entao a input '#end-do-mapa' irá ficar vermelha
E ele continua no formulário

@campos_obg_2
Cenario: Teste campos obrigatórios 2
Quando entro na pagina
Quando clico no botão de novo
E digito um 'brasil, vera cruz rua joao se' na input do mapa
Entao clico em Salvar
Entao a input dos campos '#ras_ref_descricao', '#ras_ref_tipo' e '#ras_ref_id_cli' ficarão vermelha
E ele continua no formulário

@campos_obg_3
Cenario: Teste campos obrigatórios 3
Quando entro na pagina
Quando clico no botão de novo
E digito um 'brasil, vera cruz rua joao se' na input do mapa
E preencho '#ras_ref_descricao', 'ras_ref_tipo' e '#ras_ref_id_cli'
E apago os dados de '#ras_ref_cidade','#ras_ref_uf','#ras_ref_pais'
E clico em Salvar
Entao os campos '#ras_ref_cidade', '#ras_ref_uf' e '#ras_ref_pais' ficarão vermelha
E ele continua no formulário


@cadastro_ponto_referencia
Esquema do Cenario: Inclusão do Ponto de Referência e botão Salvar
Quando entro na pagina
Quando clico no botão de novo
E digito um <endereço> na input do mapa
E os campos cidade <ras_ref_cidade> campo "#ras_ref_cidade", estado <ras_ref_uf> campo '#ras_ref_uf', pais <ras_ref_pais> campo '#ras_ref_pais' devem ser preenchidos automaticamente
# E o marker deverá ser e posicionado no endereço selecionado no mapa
E deve ser selecionado o cliente no campo <ras_ref_id_cli>
E preencho o campo descrição <ras_ref_descricao>
E seleciono um tipo de cadastro no campo <ras_ref_tipo(valor)> 
E clicar no botao "#abrir_modal"
E selecionar o icone "firstaid"
Então clico em Salvar
# E deve ser exibido o elemento de alerta iziToast
# E deve ser exibida mensagem de sucesso iziToast
Então deve buscar o registro cadastrado na grid
E deve consultar o registro em mapa do Painel de Bordo
E deve consultar o registro em mapa Geral
E deve consultar o registro em mapa do Dashboard
E deve consultar o registro em Relatorio de rotas
E deve consultar o registro em veiculos próximos
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo
# E deve consultar o registro em relatório dos pontos de referencia 
E deve consultar o registro em registro de permanência em ponto


Exemplos:
|endereço                    |ras_ref_cidade  |ras_ref_uf  |ras_ref_pais  |ras_ref_id_cli   |ras_ref_descricao                 |ras_ref_tipo(valor)|
|"Brasil, Garça"             |"Garça"         |"São Paulo" |"Brasil"      |"15931"          |"automatizaçõesÇensácionais"      |"2"                |
|"Brasil, São Paulo, Marilia"|"Marília"       |"São Paulo" |"Brasil"      |"15931"          |"lúca$$~Consa"                    |"1"                |
|"Brasil, São Paulo, Alvinl"|"Alvinlândia"       |"São Paulo" |"Brasil"      |"15931"          |"lucas consa"                    |"1"                |

@cadastro_por_painel_de_bordo
Cenario: Cadastro do ponto pelo Mapa Painel de Bordo
Quando acesso a página 'painel_bordo_controller/index/145474'
E clico na opção de seleção no ponto
E seleciono uma opção no mapa
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "#cidade-ponto-referencia-mapa", estado "São Paulo" campo '#estado-ponto-referencia-mapa', pais "Brasil" campo '#pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "32"
E clico em Criar
E deve ser exibido o elemento de alerta antigo
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência
E deve consultar o registro em mapa Geral
E deve consultar o registro em mapa do Dashboard
E deve consultar o registro em Relatorio de rotas
E deve consultar o registro em veiculos próximos
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo
# E deve consultar o registro em relatório dos pontos de referencia 
E deve consultar o registro em registro de permanência em ponto

@cadastro_por_painel_de_bordo_2
Cenario: Cadastrando um ponto de referencia atraves de um icone do mapa
Quando acesso a página 'painel_bordo_controller/index/145474'
E clico no icone dentro do mapa
E selecionarei o icone de cadastro de ponto de referencia
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "#cidade-ponto-referencia-mapa", estado "São Paulo" campo '#estado-ponto-referencia-mapa', pais "Brasil" campo '#pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "30"
E clico em Criar
E deve ser exibido o elemento de alerta antigo
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência
E deve consultar o registro em mapa Geral
E deve consultar o registro em mapa do Dashboard
E deve consultar o registro em Relatorio de rotas
E deve consultar o registro em veiculos próximos
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo
# E deve consultar o registro em relatório dos pontos de referencia 
E deve consultar o registro em registro de permanência em ponto

@cadastro_por_mapa_geral
Cenario: Realizar um cadastro de ponto de referencia mo mapa geral
Quando acesso a página 'mapaGeral'
E pesquisar uma identificação de um veiculo
E clico na opção de seleção no ponto
E seleciono uma opção no mapa
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "#cidade-ponto-referencia-mapa", estado "São Paulo" campo '#estado-ponto-referencia-mapa', pais "Brasil" campo '#pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "32"
E clico em Criar
E deve ser exibido o elemento de alerta antigo
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência
E deve consultar o registro em mapa do Painel de Bordo
E deve consultar o registro em mapa do Dashboard
E deve consultar o registro em Relatorio de rotas
E deve consultar o registro em veiculos próximos
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo
# E deve consultar o registro em relatório dos pontos de referencia 
E deve consultar o registro em registro de permanência em ponto

@cadastro_por_mapa_geral_2
Cenario: Cadastrando um ponto pelo mapa geral a partir do mapa
Quando acesso a página 'mapaGeral'
E pesquisar uma identificação de um veiculo
E clico no icone dentro do mapa
E selecionarei o icone de cadastro de ponto de referencia
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "#cidade-ponto-referencia-mapa", estado "São Paulo" campo '#estado-ponto-referencia-mapa', pais "Brasil" campo '#pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "30"
E clico em Criar
E deve ser exibido o elemento de alerta antigo
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência
E deve consultar o registro em mapa do Painel de Bordo
E deve consultar o registro em mapa do Dashboard
E deve consultar o registro em Relatorio de rotas
E deve consultar o registro em veiculos próximos
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo
# E deve consultar o registro em relatório dos pontos de referencia 
E deve consultar o registro em registro de permanência em ponto

@cadastro_por_dashboard
Cenario: Cadastro de ponto de referencia pela tela de Dashboard
Quando clico na opção de seleção no ponto
E seleciono uma opção no mapa do Dashboard
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "#cidade-ponto-referencia-mapa", estado "São Paulo" campo '#estado-ponto-referencia-mapa', pais "Brasil" campo '#pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "32"
E clico em Criar
E deve ser exibido o elemento de alerta antigo
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência
E deve consultar o registro em mapa Geral
E deve consultar o registro em mapa do Painel de Bordo
E deve consultar o registro em Relatorio de rotas
E deve consultar o registro em veiculos próximos
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo
# E deve consultar o registro em relatório dos pontos de referencia 
E deve consultar o registro em registro de permanência em ponto



# -----
# Cenário: Edição do cadastro de Ponto de Referência
# Quando eu clico no botão de editar
# Então deve abrir o formulário preenchido 
# 
# Esquema do Cenário: Edição do Ponto de Referência e botão Salvar
# Quando eu busco o registro na grid
# Então devo selecionar o registro
# E clicar no botão Editar
# Então edito "<ras_red_descricao>" "<ras_ref_cidade>", "<ras_ref_uf>", "<ras_ref_pais>"
# E clicar no botão Salvar
# Então deve ser exibido o elemento de alerta
# E deve ser exibida mensagem de sucesso
# Então deve buscar o registro cadastrado na grid
# 
# -----
# Cenário: Exclusão do Ponto de Referência
# Quando eu clico no botão de excluir o Ponto de Referência
# Então deve ser exibida janela para confirmação
# 
# Esquema do Cenário: Exclusão do Ponto de Referência
# Quando eu busco o registro na grid
# Então devo selecionar o registro
# E clicar no botão Excluir
# Então deve ser exibido o elemento de alerta
# E deve ser exibida mensagem de confirmação de exclusão
# Então devo clicar no botão Sim
# Então deve ser exibido o elemento ne alerta
# E deve ser exibida mensagem de sucesso