# language: pt

    Funcionalidade: Testar automaticamente a tela de Acesso

    Contexto: Login no sistema
    Dado o login no sistema
    E entro na pagina

    @teste_botao_novo
    Cenario: Teste botão adicionar
    Quando clico em adicionar
    Entao a pagina é redirecionada para o formulario de cadastro
 
    @teste_botao_cancelar
    Cenario: Teste botão cancelar no formulario
    Quando clico em adicionar
    Entao a pagina é redirecionada para o formulario de cadastro
    E clico em cancelar
    E deve ser exibido o elemento de alerta cancelar
    Então clico em 'sim' 
    E retorno para a grid
 
    @teste_input_obrigatória
    Cenario: Testando inputs obrigatórias
    Quando clico em adicionar 
    E adiciono o fabricante "3", a operadora "3", o numero do chip "14996977856", IMEI "NUMSEI01"
    E clico em salvar
    Entao os campos de Produtos e ID equipamento serão obrigatórios
 
    @teste_input_obrigatoria
    Cenario: Testando se não há outra input obrigatória não verificada
    Quando clico em adicionar
    E adiciono o ID do equipamento "154512542", o fabricante "3" e o produto "28"
    E clico em salvar
    Entao deve ser exibido o elemento de alerta sucesso
    E deve ser exibida mensagem de sucesso
    E retorno para a grid
    E verifico se o registro aparece na grid '154512542'
 
    # @teste_fabricante/produto_info
    # Cenario: Testar todos os fabricantes e seus respectivos produtos verificando se em cada um possui informações de configurações
    # Quando clico em adicionar
    # E verifico se todos os equipamentos e produtos tem informações de configuração
#  
    # @teste_configuracao_pop-up
    # Cenario: Testar Pop-Up  
    # Quando clico em adicionar
    # Entao seleciono todos os equipamentos verificando as configurações do produto

    @adicionar_acesso
    Esquema do Cenario: Adicionar um novo acesso e consultar suas telas associadas
    Quando clico em adicionar
    E pesquiso um produto <produto>
    E os campos fabricante e produto devem ser preenchidos automaticamente com os valores <fabricante> e <idProduto>
    E preencho o restante dos campos <operadora>, <idEquipamento>, <chip>, <linha>, <imei>, <etiqueta>
    E se for selecionado o produto "F/Cell", seleciono "469"
    E se for selecionado o produto "LMU 2630/2720", seleciono "1"
    Entao clico em salvar
    E deve ser exibido o elemento de alerta sucesso
    E deve ser exibida mensagem de sucesso
    E verifico se o registro aparece na grid <idEquipamento>
    # E ativo o registro  
    # E deve ser exibido o elemento de alerta sucesso
    # E deve ser exibida mensagem de sucesso
    # E verifico se os acessos livres foram diminuidos e os utilizados aumentados

     Exemplos:
        |produto        |fabricante|idProduto |operadora|idEquipamento               |chip         |linha |imei    |etiqueta|
        |"GT300(Concox)"| "5"      |   "127"  |"3"      |"12345678912345678912"      |"14996977689"|"sla?"|"123321"|'1'     |
        |"GT300(Concox)"| "5"      |   "127"  |"3"      |"12345678912345678912"      |"14996977689"|"sla?"|"123321"|'1'     |
        |"F/Cell"       | "12"     |   "34"   |"3"      |"8888"                      |"14996977689"|"sla?"|"123321"|'1'     |
        |"2630"         | "3"      |   "33"   |"3"      |"4444"                      |"14996977689"|"sla?"|"123321"|'1'     |

    @adicionar_acesso
    Esquema do Cenario: Ativar varios registros
    Quando eu pesquiso um registro <equipamento>
    E ativo todos os registros
    # E verifico se os acessos livres foram diminuidos e os utilizados aumentados
    Mas nao podera ter mais de um registro ativo
 
    Exemplos: 
        |equipamento                 |
        |"12345678912345678912"      |
        |"4444"                      |       
 
    @adicionar_acesso 
    Cenario: Consulta na tela de Oficina
    Quando eu seleciono o equipamento "12345678912345678912"
    E eu entro na pagina "oficina/novo"
    Entao verifico se o produto cadastrado está na opção de seleção
     
    @adicionar_acesso
    Esquema do Cenario: Consulta na tela de Cadastro de Veiculo
    Quando eu seleciono o equipamento <equipamento>
    E eu entro na pagina "cadastros/veiculo_controller/novo"
    Entao verifico se o produto cadastrado está na opção de seleção
# 
    Exemplos:
        |equipamento                 |
        |"12345678912345678912"      |
        |"4444"                      |
#  
    @adicionar_acesso
    Esquema do Cenario: Vincular equipamento na tela de Oficina
    Quando eu seleciono o equipamento <equipamento>
    E eu entro na pagina "oficina/novo"
    E vinculo um equipamento a um veiculo no cadastro de "oficina" com o <produto> e o <veiculo>
    Entao clico em salvar  
    E deve ser exibido o elemento de alerta sucesso
    E deve ser exibida mensagem de sucesso
# 
    Exemplos:
        |equipamento                 |produto|veiculo |
        |"12345678912345678912"      |"127"  |"344411"|
        |"4444"                      |"33"   |"344522"|

 
   @adicionar_acesso
    Cenario: Verificar se o equipamento vinculado não aparece na tela de cadastro de veiculo
    Quando eu seleciono o equipamento "12345678912345678912"
    E eu entro na pagina "cadastros/veiculo_controller/novo"
    E verifico se o produto não está na opção de seleção 'cadVeiculo'    
  
    @adicionar_acesso
    Cenario: desvinculando um equipamento da tela de oficina
    Quando eu seleciono o equipamento "12345678912345678912"
    E eu entro na pagina "oficina"
    E pesquiso o equipamento
    E verifico se ele está instalado
    Entao clico em desvincular
    E deve ser exibido o elemento de confirmação de exclusao
    E devo clicar em "sim"
    E deve ser exibido o elemento de alerta sucesso 
    E deve ser exibida mensagem de sucesso
    E verifico se o registro está desvinculado

    @adicionar_acesso
    Cenario: Vincular equipamento na cadastro de veiculo
    Quando eu seleciono o equipamento "12345678912345678912"
    E eu entro na pagina "cadastros/veiculo_controller/novo"
    E vinculo um equipamento a um veiculo no cadastro de "cadVeiculo" com o "" e o ""
    Entao clico em salvar  
    E deve ser exibido o elemento de alerta sucesso
    E deve ser exibida mensagem de sucesso
   
    @adicionar_acesso
    Cenario: Verificar se o equipamento vinculado não aparece na tela de oficina
    Quando eu seleciono o equipamento "12345678912345678912"
    E eu entro na pagina "oficina/novo"
    E verifico se o produto não está na opção de seleção 'cadVeiculo'
 
    @adicionar_acesso
    Cenario: desvinculando um equipamento da tela de cadastro de veiculo
    Quando eu seleciono o equipamento "12345678912345678912"
    E eu entro na pagina "oficina"
    E pesquiso o equipamento 
    E verifico se ele está instalado
    Entao clico em desvincular
    E deve ser exibido o elemento de confirmação de exclusao
    E devo clicar em "sim"
    E deve ser exibido o elemento de alerta sucesso
    E deve ser exibida mensagem de sucesso
    E verifico se o registro está desvinculado

    @desativando_registro
    Cenario: Desativando um registro com oficina
    Quando eu seleciono o equipamento "4444"
    E verifico se tem oficina
    E clico em desativar
    Entao deve ser exibido o elemento de alerta sucesso
    E deve ser exibida a mensagem de alerta
    E verifico se o registro está desativado na grid    

    @excluir_acesso
    Cenario: excluindo um acesso ativo
    Quando eu seleciono o equipamento "12345678912345678912"
    E o registro estiver ativo
    E clico em excluir
    Entao deve ser exibido o elemento de alerta sucesso
    E devo clicar em 'sim'
    Entao deve ser exibido o elemento de alerta sucesso
    E deve ser exibida a mensagem de alerta
    E retorno para a grid
    E verifico se o registro aparece na grid "12345678912345678912"


    @excluir_acesso
    Cenario: Excluindo um acesso desativado
    Quando eu seleciono o equipamento "8888"
    E o registro estiver desativado
    E clico em excluir
    E deve ser exibido o elemento de confirmação de exclusao
    E devo clicar em "sim"
    E deve ser exibido o elemento de alerta sucesso
    E deve ser exibida mensagem de sucesso
    E verifico se o registro nao aparece na grid "8888"

    
    @excluir_acesso_oficina
    Cenario: Excluindo um acesso com oficina
    Quando eu seleciono o equipamento "4444"
    E o registro estiver com oficina
    E clico em excluir 
    E deve ser exibido o elemento de confirmação de exclusao
    E devo clicar em "sim"
    E deve ser exibido o elemento de alerta sucesso
    E deve ser exibida a mensagem de alerta

    @editando_acesso
    Cenario: Editando um acesso ativo e ou com oficina
    Quando eu seleciono o equipamento "12345678912345678912"
    E clico em editar
    E verifico se os campos fabricante, produto, operadora e Id equipamento estão bloqueados
    E altero os campos
    Entao clico em salvar
    E deve ser exibido o elemento de alerta sucesso
    E deve ser exibida mensagem de sucesso
    E verifico o registro na grid
    E clico em editar 
    Entao os campos estarao editados

    @editando_acesso
    Cenario: Editando um acesso desativado e sem oficina
    Quando eu seleciono o equipamento "154512542"
    E verifico se todos os campos estão livres
    E clico em editar
    E altero os campos
    Entao clico em salvar
    E deve ser exibido o elemento de alerta sucesso
    E deve ser exibida mensagem de sucesso
    E verifico o registro na grid
    E clico em editar 
    Entao os campos estarao editados    

    @teste_exportacao
    Cenario: Exportando os registros da grid
    Quando eu clico em selecione
    E clico na opção de seleção
    Entao será feito o download 