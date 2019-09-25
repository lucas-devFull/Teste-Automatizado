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
E deve ser exibido o elemento de alerta cancelar
Então clico em 'sim' 
E retorno para a grid

@teste_botao_cancelar_2
Cenario: Quando eu cancelo um cadastro
Quando entro na pagina
Quando clico no botão de novo
E devo ir ao cadastro de Ponto de Referência
Então clico no botão cancelar
E deve ser exibido o elemento de alerta cancelar
Então clico em 'nao' 
E ele continua no formulário
 
@campos_obg
Cenario: Teste campos obrigatórios
Quando entro na pagina
Quando clico no botão de novo
E clico em Salvar
Entao a input 'end-do-mapa' irá ficar vermelha
E ele continua no formulário
 
@campos_obg_2
Cenario: Teste campos obrigatórios 2
Quando entro na pagina
Quando clico no botão de novo
E digito um 'brasil, vera cruz rua joao se' na input do mapa
Entao clico em Salvar
Entao a input dos campos 'ras_ref_descricao', 'ras_ref_tipo' e 'ras_ref_id_cli' ficarão vermelha
E ele continua no formulário

@campos_obg_3
Cenario: Teste campos obrigatórios 3
Quando entro na pagina
Quando clico no botão de novo
E digito um 'brasil, vera cruz rua joao se' na input do mapa
E preencho 'ras_ref_descricao', 'ras_ref_tipo' e 'ras_ref_id_cli'
E apago os dados de 'ras_ref_cidade','ras_ref_uf','ras_ref_pais'
E clico em Salvar
Entao os campos 'ras_ref_cidade', 'ras_ref_uf' e 'ras_ref_pais' ficarão vermelha
E ele continua no formulário


@cadastro_ponto_referencia
Esquema do Cenario: Inclusão do Ponto de Referência e botão Salvar
Quando entro na pagina
Quando clico no botão de novo
E digito um <endereço> na input do mapa
E os campos cidade <ras_ref_cidade> campo "ras_ref_cidade", estado <ras_ref_uf> campo 'ras_ref_uf', pais <ras_ref_pais> campo 'ras_ref_pais' devem ser preenchidos automaticamente
E deve ser selecionado o cliente no campo <ras_ref_id_cli>
E preencho o campo descrição <ras_ref_descricao>
E seleciono um tipo de cadastro no campo <ras_ref_tipo(valor)> 
E clicar no botao "abrir_modal"
E selecionar o icone "firstaid"
Então clico em Salvar
# E deve ser exibido o elemento de alerta iziToast
# E deve ser exibida mensagem de sucesso iziToast
Então deve buscar o registro cadastrado na grid como "cadastro"
E deve consultar o registro em mapa do Painel de Bordo como "cadastro"
E deve consultar o registro em mapa Geral como "cadastro"
E deve consultar o registro em mapa do Dashboard como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro"
E deve consultar o registro em registro de permanência em ponto como "cadastro"


Exemplos:
|endereço                    |ras_ref_cidade  |ras_ref_uf  |ras_ref_pais  |ras_ref_id_cli   |ras_ref_descricao                 |ras_ref_tipo(valor)|
|"Brasil, Garça"             |"Garça"         |"São Paulo" |"Brasil"      |"22647"          |"automatizaçõesÇensácionais"      |"2"                |
|"Brasil, São Paulo, Marilia"|"Marília"       |"São Paulo" |"Brasil"      |"22647"          |"lúca$$~Consa"                    |"1"                |
|"Brasil, São Paulo, Alvinl" |"Alvinlândia"   |"São Paulo" |"Brasil"      |"22647"          |"lucas consa"                     |"1"                |

@cadastro_por_painel_de_bordo
Cenario: Cadastro do ponto pelo Mapa Painel de Bordo
Quando acesso a página 'painel_bordo_controller/index/129167'
E clico na opção de seleção no ponto
E seleciono uma opção no mapa
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "cidade-ponto-referencia-mapa", estado "São Paulo" campo 'estado-ponto-referencia-mapa', pais "Brasil" campo 'pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "32"
E clico em Criar
E deve ser exibido o elemento de alerta antigo 1  
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o registro em mapa Geral como "cadastro"
E deve consultar o registro em mapa do Dashboard como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro"
E deve consultar o registro em registro de permanência em ponto como "cadastro"

@cadastro_por_painel_de_bordo_2
Cenario: Cadastrando um ponto de referencia atraves de um icone do mapa
Quando acesso a página 'painel_bordo_controller/index/129167'
E clico no icone dentro do mapa
E selecionarei o icone de cadastro de ponto de referencia
Entao abrirá um modal de cadastro
E os campos cidade "Garça" campo "cidade-ponto-referencia-mapa", estado "São Paulo" campo 'estado-ponto-referencia-mapa', pais "Brasil" campo 'pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "30"
E clico em Criar
E deve ser exibido o elemento de alerta antigo 1
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o registro em mapa Geral como "cadastro"
E deve consultar o registro em mapa do Dashboard como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro"
E deve consultar o registro em registro de permanência em ponto como "cadastro"
 
@cadastro_por_mapa_geral
Cenario: Realizar um cadastro de ponto de referencia mo mapa geral
Quando acesso a página 'mapaGeral'
E pesquisar uma identificação de um veiculo
E clico na opção de seleção no ponto
E seleciono uma opção no mapa
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "cidade-ponto-referencia-mapa", estado "São Paulo" campo 'estado-ponto-referencia-mapa', pais "Brasil" campo 'pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "32"
E clico em Criar
E deve ser exibido o elemento de alerta antigo 1
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o registro em mapa do Painel de Bordo como "cadastro"
E deve consultar o registro em mapa do Dashboard como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro"
E deve consultar o registro em registro de permanência em ponto como "cadastro"

# @cadastro_por_mapa_geral_2
@oi
Cenario: Cadastrando um ponto pelo mapa geral a partir do mapa
Quando acesso a página 'mapaGeral'
E pesquisar uma identificação de um veiculo
E clico no icone dentro do mapa
E selecionarei o icone de cadastro de ponto de referencia
Entao abrirá um modal de cadastro
E os campos cidade "Garça" campo "cidade-ponto-referencia-mapa", estado "São Paulo" campo 'estado-ponto-referencia-mapa', pais "Brasil" campo 'pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "30"
E clico em Criar
E deve ser exibido o elemento de alerta antigo 1
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o registro em mapa do Painel de Bordo como "cadastro"
E deve consultar o registro em mapa do Dashboard como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro"
E deve consultar o registro em registro de permanência em ponto como "cadastro"

@cadastro_por_dashboard
Cenario: Cadastro de ponto de referencia pela tela de Dashboard
Quando clico nos clusters 
E clico na opção de seleção no ponto
E seleciono uma opção no mapa do Dashboard
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "cidade-ponto-referencia-mapa", estado "São Paulo" campo 'estado-ponto-referencia-mapa', pais "Brasil" campo 'pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "32"
E clico em Criar
E deve ser exibido o elemento de alerta antigo 1
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o registro em mapa Geral como "cadastro"
E deve consultar o registro em mapa do Painel de Bordo como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro"
E deve consultar o registro em registro de permanência em ponto como "cadastro"

@cadastro_por_dashboard_2
Cenario: Cadastrando o ponto por um veiculo rastreado
Quando clico nos clusters 
E clico no icone dentro do mapa
E selecionarei o icone de cadastro de ponto de referencia
Entao abrirá um modal de cadastro
E os campos cidade "Garça" campo "cidade-ponto-referencia-mapa", estado "São Paulo" campo 'estado-ponto-referencia-mapa', pais "Brasil" campo 'pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "cliente-ponto-referencia-mapa", descrição do ponto 'observacao-ponto-referencia-mapa' e o tipo do ponto "tipo-ponto"
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "32"
E clico em Criar
E deve ser exibido o elemento de alerta antigo 1
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o registro em mapa Geral como "cadastro"
E deve consultar o registro em mapa do Painel de Bordo como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro"
E deve consultar o registro em registro de permanência em ponto como "cadastro"

@excluir_ponto_referencia
Cenario: Excluindo um registro
Quando entro na pagina
E Seleciono um registro "Teste Tipo Ponto"
E clico em excluir
Entao deve ser exibido o elemento de alerta exclusão
E clico em sim
E deve ser exibida mensagem de excluido com sucesso iziToast
E devo verificar se o cadastro não está mais na grid como "exclusao"
E deve consultar o registro em mapa do Painel de Bordo como "exclusao"
E deve consultar o registro em mapa Geral como "exclusao"
E deve consultar o registro em mapa do Dashboard como "exclusao"
E deve consultar o registro em Relatorio de rotas como "exclusao"
E deve consultar o registro em veiculos próximos como "exclusao"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "exclusao"
E deve consultar o registro em registro de permanência em ponto como "exclusao"

@excluir_por_painel_bordo
Cenario: Excluindo um registro pelo painel de bordo
Quando entro na pagina
E Seleciono um registro "Téste Novínho"
E deve consultar o registro em mapa do Painel de Bordo como "cadastro"
E clico no icone do ponto de referencia
Entao abrirá um modal de cadastro
E clico em excluir pela modal
# Entao deve ser exibido o elemento de alerta exclusão
# E clico em sim
# E deve ser exibida mensagem de excluido com sucesso antigo
E o ponto não deverá estar do mapa
E o ponto não deverá estar select
E deve consultar o registro em Cadastro de Ponto de Referência modal como "exclusao"
E deve consultar o registro em mapa Geral como "exclusao"
E deve consultar o registro em mapa do Dashboard como "exclusao"
E deve consultar o registro em Relatorio de rotas como "exclusao"
E deve consultar o registro em veiculos próximos como "exclusao"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "exclusao"
E deve consultar o registro em registro de permanência em ponto como "exclusao"

@excluir_por_mapa_geral
Cenario: Excluindo um registro pelo Mapa Geral
Quando entro na pagina
E Seleciono um registro "Téste Novínho"
E deve consultar o registro em mapa Geral como "cadastro"
E clico no icone do ponto de referencia
Entao abrirá um modal de cadastro
E clico em excluir pela modal
# Entao deve ser exibido o elemento de alerta exclusão
# E clico em sim
# E deve ser exibida mensagem de excluido com sucesso antigo
E o ponto não deverá estar do mapa
E o ponto não deverá estar select
E deve consultar o registro em Cadastro de Ponto de Referência modal como "exclusao"
E deve consultar o registro em mapa do Painel de Bordo como "exclusao"
E deve consultar o registro em mapa do Dashboard como "exclusao"
E deve consultar o registro em Relatorio de rotas como "exclusao"
E deve consultar o registro em veiculos próximos como "exclusao"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "exclusao"
E deve consultar o registro em registro de permanência em ponto como "exclusao"

@excluir_por_dashboard
Cenario: Excluindo um regidtro pelo Dashboard
Quando entro na pagina
E Seleciono um registro "Téste Novínho"
E deve consultar o registro em mapa do Dashboard como "cadastro"
E clico no icone do ponto de referencia
Entao abrirá um modal de cadastro
E clico em excluir pela modal
# Entao deve ser exibido o elemento de alerta exclusão
# E clico em sim
# E deve ser exibida mensagem de excluido com sucesso antigo
E o ponto não deverá estar do mapa
E o ponto não deverá estar select
E deve consultar o registro em Cadastro de Ponto de Referência modal como "exclusao"
E deve consultar o registro em mapa do Painel de Bordo como "exclusao"
E deve consultar o registro em mapa Geral como "exclusao"
E deve consultar o registro em Relatorio de rotas como "exclusao"
E deve consultar o registro em veiculos próximos como "exclusao"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "exclusao"
E deve consultar o registro em registro de permanência em ponto como "exclusao"

@excluir_por_rel_rotas
Cenario: Excluindo um regidtro pelo Relatorio de Rotas
Quando entro na pagina
E Seleciono um registro "Téste Novínho"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E clico no icone do ponto de referencia
Entao abrirá um modal de cadastro
E clico em excluir pela modal
# Entao deve ser exibido o elemento de alerta exclusão
# E clico em sim
# E deve ser exibida mensagem de excluido com sucesso antigo
E o ponto não deverá estar do mapa
E o ponto não deverá estar select
E deve consultar o registro em Cadastro de Ponto de Referência modal como "exclusao"
E deve consultar o registro em mapa do Painel de Bordo como "exclusao"
E deve consultar o registro em mapa Geral como "exclusao"
E deve consultar o registro em mapa do Dashboard como "exclusao"
E deve consultar o registro em veiculos próximos como "exclusao"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "exclusao"
E deve consultar o registro em registro de permanência em ponto como "exclusao"

# Edição
@editando_ponto_referencia
Cenario: Editando um registro
Quando entro na pagina
E Seleciono um registro "Téste Novínho"
E clico em editar
Então devo ir ao cadastro de Ponto de Referência
E digito um "Brasil,Pernambuco Fernando de noronha" na input do mapa
E os campos cidade 'Fernando de Noronha' campo "ras_ref_cidade", estado "Pernambuco" campo 'ras_ref_uf', pais 'Brasil' campo 'ras_ref_pais' devem ser preenchidos automaticamente
E preencho o campo descrição "!Edição!"
E seleciono um tipo de cadastro no campo '2562' 
E clicar no botao "abrir_modal"
E selecionar o icone "nordicski"
Então clico em Salvar
# E deve ser exibido o elemento de alerta iziToast
# E deve ser exibida mensagem de sucesso iziToast
Então deve buscar o registro cadastrado na grid como "cadastro"
E seleciono o registro alterado "!Edição!"
E clico em editar
E as informações dos campos estaram editadas com os campos "ras_ref_id_cli","ras_ref_descricao","ras_ref_tipo","abrir_modal"  
E deve consultar o registro em mapa do Painel de Bordo como "cadastro"
E deve consultar o registro em mapa Geral como "cadastro"
E deve consultar o registro em mapa do Dashboard como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro" 
E deve consultar o registro em registro de permanência em ponto como "cadastro"

@editando_por_painel_de_bordo
Cenario: Editando um registro por painel de bordo
Quando entro na pagina
E Seleciono um registro "automatizaçõesÇensácionais"
E deve consultar o registro em mapa do Painel de Bordo como "cadastro"
E clico no ponto selecionado
Entao abrirá um modal de cadastro
E e altero os campos cidade 'Garça' campo "cidade-ponto-referencia-mapa", estado 'São Paulo' campo "estado-ponto-referencia-mapa", pais 'Brasil' campo 'pais-ponto-referencia-mapa'
E preencho o campo descrição "!Edição!" pela modal do mapa
E seleciono um tipo de cadastro no campo '7' pela modal do mapa
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "108"
Entao clico em Criar
E seleciono novamente o registro
E clico no ponto selecionado
Entao abrirá um modal de cadastro
E os campos cidade, estado e pais estaram editados
E as informações dos campos estaram editadas com os campos "cliente-ponto-referencia-mapa","observacao-ponto-referencia-mapa","tipo-ponto","cad-pointer"  
E deve consultar o registro em mapa Geral como "cadastro"
E deve consultar o registro em mapa do Dashboard como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro" 
E deve consultar o registro em registro de permanência em ponto como "cadastro"
 
@editando_por_Dashboard
Cenario: Editando um registro pelo Dashoboard
Quando entro na pagina
E Seleciono um registro "automatizaçõesÇensácionais"
E deve consultar o registro em mapa do Dashboard como "cadastro"
E clico no ponto selecionado
Entao abrirá um modal de cadastro
E e altero os campos cidade 'Garça' campo "cidade-ponto-referencia-mapa", estado 'São Paulo' campo "estado-ponto-referencia-mapa", pais 'Brasil' campo 'pais-ponto-referencia-mapa'
E preencho o campo descrição "!Edição!" pela modal do mapa
E seleciono um tipo de cadastro no campo '7' pela modal do mapa
E clicar no botao "cad-pointer"
E selecionar o icone - mapa "108"
Entao clico em Criar
E seleciono novamente o registro
E clico no ponto selecionado
Entao abrirá um modal de cadastro
E os campos cidade, estado e pais estaram editados
E as informações dos campos estaram editadas com os campos "cliente-ponto-referencia-mapa","observacao-ponto-referencia-mapa","tipo-ponto","cad-pointer"  
E deve consultar o registro em mapa do Painel de Bordo como "cadastro"
E deve consultar o registro em mapa Geral como "cadastro"
E deve consultar o registro em Relatorio de rotas como "cadastro"
E deve consultar o registro em veiculos próximos como "cadastro"
E deve consultar o registro em cadastro de itinerario
E deve consultar o registro em cadastro de itinerario_novo como "cadastro" 
E deve consultar o registro em registro de permanência em ponto como "cadastro"

@tipo_ponto_referencia_cadastro
Cenario: Quando um registro cadastra e escolhe um tipo de ponto de referencia especiíco
Quando entro na pagina
E clico no botão de novo
E digito um "Brasil, marilia" na input do mapa
E os campos cidade "Marília" campo "ras_ref_cidade", estado "São Paulo" campo 'ras_ref_uf', pais "Brasil" campo 'ras_ref_pais' devem ser preenchidos automaticamente
E deve ser selecionado o cliente no campo "22647"
E preencho o campo descrição "ponto de referencia"
E clico no icone para adicionar um tipo de ponto de referencia novo
E irá abrir um pop-up
E adiciono uma descrição para o tipo "ponto de referencia"
E clico no pop-up em "salvar"
# E deve ser exibido o elemento de alerta iziToast
# E deve ser exibida mensagem de sucesso iziToast
Então clico em Salvar
# E deve ser exibido o elemento de alerta iziToast
# E deve ser exibida mensagem de sucesso iziToast
Então deve buscar o registro cadastrado na grid como "cadastro"
E deve consultar o tipo do ponto em mapa do Painel de Bordo como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa Geral como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa do Dashboard como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em Relatorio de permanência em ponto como "cadastro"
# E verifico se o tipo do campo 'idPontoTipoRef' está selecionado como "cadastro"

@tipo_ponto_referencia_cadastro_painel_de_bordo
Cenario: Quando um registro cadastra e escolhe um tipo de ponto de referencia especiíco
Quando acesso a página 'painel_bordo_controller/index/129167'
E clico na opção de seleção no ponto
E seleciono uma opção no mapa
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "cidade-ponto-referencia-mapa", estado "São Paulo" campo 'estado-ponto-referencia-mapa', pais "Brasil" campo 'pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "22647", descrição do ponto 'Painel de Bordo' e o tipo do ponto "Painel de Bordo" no mapa
E clico em Criar
E deve ser exibido o elemento de alerta antigo 
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o tipo do ponto em cadastro de ponto referencia como "cadastro"
E verifico se o tipo do campo 'ras_ref_tipo' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa Geral como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa do Dashboard como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em Relatorio de permanência em ponto como "cadastro"
# E verifico se o tipo do campo 'idPontoTipoRef' está selecionado como "cadastro"

@tipo_ponto_referencia_cadastro_mapa_geral
Cenario: Quando um registro cadastra e escolhe um tipo de ponto de referencia especiíco
Quando acesso a página 'mapaGeral'
E clico na opção de seleção no ponto
E seleciono uma opção no mapa
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "cidade-ponto-referencia-mapa", estado "São Paulo" campo 'estado-ponto-referencia-mapa', pais "Brasil" campo 'pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "22647", descrição do ponto 'Mapa Geral' e o tipo do ponto "Mapa Geral" no mapa
E clico em Criar
E deve ser exibido o elemento de alerta antigo 
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o tipo do ponto em cadastro de ponto referencia como "cadastro"
E verifico se o tipo do campo 'ras_ref_tipo' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa do Painel de Bordo como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa do Dashboard como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em Relatorio de permanência em ponto como "cadastro"
# E verifico se o tipo do campo 'idPontoTipoRef' está selecionado como "cadastro"

@tipo_ponto_referencia_cadastro_dashboard
Cenario: Quando um registro cadastra e escolhe um tipo de ponto de referencia especiíco
Quando clico na opção de seleção no ponto
E seleciono uma opção no mapa
Entao abrirá um modal de cadastro
# E os campos cidade "Garça" campo "cidade-ponto-referencia-mapa", estado "São Paulo" campo 'estado-ponto-referencia-mapa', pais "Brasil" campo 'pais-ponto-referencia-mapa' devem ser preenchidos automaticamente
E devo inserir os dados, cliente "22647", descrição do ponto 'Dashboard' e o tipo do ponto "Dashboard" no mapa
E clico em Criar
E deve ser exibido o elemento de alerta antigo 
E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o tipo do ponto em cadastro de ponto referencia como "cadastro"
E verifico se o tipo do campo 'ras_ref_tipo' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa do Painel de Bordo como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa Geral como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em Relatorio de permanência em ponto como "cadastro"
# E verifico se o tipo do campo 'idPontoTipoRef' está selecionado como "cadastro"

@tipo_ponto_referencia_exclusao
Cenario: entro em um registro e excluo um tipo de ponto de referencia
Quando entro na pagina
E Seleciono um registro "ponto de referencia"
E clico em editar
E devo ir ao cadastro de Ponto de Referência
Entao excluo o tipo de ponto de referencia "telaPrincipal"
E deve ser exibido o elemento de alerta iziToast
E deve ser exibida mensagem de sucesso iziToast
E deve consultar o tipo do ponto em mapa do Painel de Bordo como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "exclusao"
E deve consultar o tipo do ponto em mapa Geral como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "exclusao"
E deve consultar o tipo do ponto em mapa do Dashboard como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "exclusao"
E deve consultar o tipo do ponto em Relatorio de permanência em ponto como "cadastro"
# E verifico se o tipo do campo 'idPontoTipoRef' está selecionado como "exclusao"

@tipo_ponto_referencia_exclusao_painel_bordo
Cenario: excluindo um tipo de referencia por painel de bordo
Quando entro na pagina
E Seleciono um registro "Painel de Bordo"
E acesso a página 'painel_bordo_controller/index/129167'
E deve consultar o tipo do ponto em mapa do Painel de Bordo como "cadastro"
E clico no ponto selecionado
Entao excluo o tipo de ponto de referencia "telaAssociada"
# E deve ser exibido o elemento de alerta antigo
# E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o tipo do ponto em cadastro de ponto referencia como "cadastro"
E verifico se o tipo do campo 'ras_ref_tipo' está selecionado como "exclusao"
E deve consultar o tipo do ponto em mapa Geral como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "exclusao"
E deve consultar o tipo do ponto em mapa do Dashboard como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "exclusao"
E deve consultar o tipo do ponto em Relatorio de permanência em ponto como "cadastro"

@tipo_ponto_referencia_exclusao_mapa_geral
Cenario: excluindo um tipo de referencia por mapageral
Quando entro na pagina
E Seleciono um registro "Mapa Geral"
E acesso a página 'mapageral'
E deve consultar o tipo do ponto em mapa do Painel de Bordo como "cadastro"
E clico no ponto selecionado
Entao excluo o tipo de ponto de referencia "telaAssociada"
# E deve ser exibido o elemento de alerta antigo
# E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o tipo do ponto em cadastro de ponto referencia como "cadastro"
E verifico se o tipo do campo 'ras_ref_tipo' está selecionado como "exclusao"
E deve consultar o tipo do ponto em mapa Geral como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "exclusao"
E deve consultar o tipo do ponto em mapa do Dashboard como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "exclusao"
E deve consultar o tipo do ponto em Relatorio de permanência em ponto como "cadastro"

@tipo_ponto_referencia_exclusao_dashboard
Cenario: excluindo um tipo de referencia por dashboard
Quando entro na pagina
E Seleciono um registro "Dashboard"
E acesso a página 'dashboard_controller'
E deve consultar o tipo do ponto em mapa do Painel de Bordo como "cadastro"
E clico no ponto selecionado
Entao excluo o tipo de ponto de referencia "telaAssociada"
# E deve ser exibido o elemento de alerta antigo
# E deve ser exibida mensagem de sucesso antigo
E deve consultar o registro em Cadastro de Ponto de Referência como "cadastro"
E deve consultar o tipo do ponto em cadastro de ponto referencia como "cadastro"
E verifico se o tipo do campo 'ras_ref_tipo' está selecionado como "exclusao"
E deve consultar o tipo do ponto em mapa Geral como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "exclusao"
E deve consultar o tipo do ponto em mapa do Dashboard como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "exclusao"
E deve consultar o tipo do ponto em Relatorio de permanência em ponto como "cadastro"

@tipo_ponto_referencia_edicao
Cenario: editando um tipo de ponto de referencia
Quando entro na pagina
E Seleciono um registro "ponto de referencia"
E clico em editar
E devo ir ao cadastro de Ponto de Referência
Entao edito o tipo de ponto de referencia para "editado ponto"
# E deve ser exibido o elemento de alerta iziToast
# E deve ser exibida mensagem de sucesso iziToast
E deve consultar o tipo do ponto em mapa do Painel de Bordo como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa Geral como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em mapa do Dashboard como "cadastro"
E clico no ponto selecionado
E verifico se o tipo do campo 'tipo-ponto' está selecionado como "cadastro"
E deve consultar o tipo do ponto em Relatorio de permanência em ponto como "cadastro"
# E verifico se o tipo do campo 'idPontoTipoRef' está selecionado como "exclusao"
