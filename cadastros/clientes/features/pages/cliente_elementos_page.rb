class Elementos_clientes < SitePrism::Page

    set_url "#{CONFIG['url_7112']}"    

    def variaveisMap(var)
        variaveis = {
            :selectFlitro => 'filtros-servidor',

            # campos 
            :NomeFantasia => 'ras_cli_desc',
            :razaoSocial => 'ras_cli_razao',
            :tipo => 'ras_cli_tipo',
            :liberado => 'ras_cli_liberado',
            :cpfCnpj => 'ras_cli_cnpj',
            :endereco => 'ras_cli_endereco',
            :bairro => 'ras_cli_bairro',
            :cidade => 'ras_cli_cidade',
            :cep => 'ras_cli_cep',
            :estado => 'ras_cli_uf',
            :pais => 'ras_cli_pais',    

            # campos Clientes Contatos
            :descContato => 'ras_cli_contato',
            :emailContato => 'ras_cli_email',
            :DDIcelular => 'ras_ccn_ddi_celular',
            :telefonecontato => 'ras_cli_mobile_phone',

            # tela de cadastro de veiculo
            :descricaoVeiculo => 'ras_vei_veiculo',
            :placaVeiculo => 'ras_vei_placa',
            :tipoVeiculo => 'ras_vei_tipo',

            # tela de acesso
            :pesquisa_produtoAcesso => 'pesquisa_produto',            
            :fabricante => 'ras_efb_id',
            :IdEquipamento => 'ras_ras_id_aparelho',
            :produto => 'ras_ras_prd_id',


            # tela de contato
            :descContato => 'ras_cli_contato',
            :DDIcontato => 'ras_ccn_ddi_celular',
            :celular => 'ras_cli_mobile_phone',
            :email => 'ras_cli_email',
            :perfilMobile => 'ras_mob_id_perfil_mobile',          
            
            # Mapa geral 2
            :selectClientes => 'clientes',
            :selectRastreados => 'rastreados',
        }
      
        if var.kind_of?(Array)
            outro = []
            for i in var
                outro << variaveis[:"#{i}"]
            end
            return outro
        else
          return variaveis[:"#{var}"]
        end
    end

    element :caixaSelecao,:xpath, "//div[@class='btn btn-default dropdown-toggle ft-button-div']"
    element :selecioneExportacao, :xpath, "//div[@id='export-dropdown']/ul[@class='dropdown-menu']/li/a[@class='exportEXCEL']"
    element :telaContatos, ".two"
    element :btn_adicionar_contato, '#adicionar-contato'

    # grid
    element :idGrid, :xpath, "//table[@id='clientes']/tbody/tr[@class='odd'][1]/td[@class='sorting_1']"
    element :idGridSelected, :xpath, "//table[@id='clientes']/tbody/tr[@class='odd selected']/td[@class='sorting_1']"
    element :nomeFantasiaGrid, :xpath, "//table[@id='clientes']/tbody/tr[@class='odd selected']/td[3]"

    # selects e inputs  
    element :nomeFantasiaInput, "#ras_cli_desc"
    element :inputGrid, :xpath, "//div[@id='clientes_filter']/label/input"
    element :ordenacaoId, :xpath, "//table[@id='clientes']/thead/tr/th[@class='sorting_asc']"

    # cadastro veiculos
    element :ordenacaoVeiculos, :xpath, "//table[@id='veiculos']/thead/tr/th[@class='sorting_asc']"
    element :idGridVeiculo, :xpath, "//table[@id='veiculos']/tbody/tr[@class='odd'][1]/td[@class='sorting_1']"

    # tela  Acesso
    element :ordenacaoAcesso, :xpath, "//table[@id='cadastro-acesso']/thead/tr/th[@class='sorting_asc']"
    element :ativarRegistro, "#ativar"
    element :produtoGridAcesso, :xpath, "//table[@id='cadastro-acesso']/tbody/tr[@class='odd'][1]/td[5]"
    element :idgridAcesso, :xpath, "//table[@id='cadastro-acesso']/tbody/tr[1]/td[@class='sorting_1']"

    # tela de Contato 
    element :pesquisaCliente, :xpath, "//div[@class='well text-right']/div[@class='row']/div[@class='col-md-10']/div[@class='input-group']/input[@class='form-control']"
    element :selecionaCliContato, :xpath, "//div[@class='well text-right']/ul[@class='list-group']/li"
    element :moverCliente, :xpath, "//div[@class='btn btn-default btn-sm move-right']"
    element :adicionarContato, "#adicionar-contato"
    element :tdEmail, "//table[@id='table-contato']/tbody/tr[@class='odd'][1]/td[4]"
    element :tdCelular, "//table[@id='table-contato']/tbody/tr[@class='odd'][1]/td[5]"

    # simulardor de GPS
    element :inputIdVeiculo, :xpath, "//input[@data-bind='id_veiculo']"
    element :lig_desl_ignicao, :xpath, "//input[@data-bind='ignicao']" 
    element :enviar_posicao, "#enviar_posicao"

    # tela de rastreados
    element :inputPesquisaRastresados, :xpath, "//div[@id='rastreados_filter']/label/input"
    element :ordenacaoRasteados, :xpath, "//table[@id='rastreados']/thead/tr/th[@class='sorting_asc']"
    element :clienteRasteados, :xpath, "//div[@id='rastreados_wrapper']/table[@id='rastreados']/tbody/tr[1]/td[1]"
    element :painelBordoMapa, ".visualizar-painel-bordo"

    #  mapa Painel de Bordo

    element :click1noMapa, :xpath, "//div[@id='map-canvas']/div[@class='leaflet-map-pane']/div[@class='leaflet-tile-pane']/div[@class='leaflet-layer']/div[@class='leaflet-tile-container leaflet-zoom-animated']/img[@class='leaflet-tile leaflet-tile-loaded'][1]"
    element :click2noMapa, :xpath, "//div[@id='map-canvas']/div[@class='leaflet-map-pane']/div[@class='leaflet-tile-pane']/div[@class='leaflet-layer']/div[@class='leaflet-tile-container leaflet-zoom-animated']/img[@class='leaflet-tile leaflet-tile-loaded'][4]"
    element :click3noMapa, :xpath, "//div[@class='leaflet-marker-pane']/div[@class='awesome-marker-icon-red awesome-marker leaflet-zoom-animated leaflet-clickable']"
    element :click4noMapa, :xpath, "//div[@class='leaflet-marker-pane']/div[@class='leaflet-marker-icon leaflet-div-icon leaflet-editing-icon leaflet-zoom-animated leaflet-clickable'][1]"

    # mapa geral
    element :inputMapaGeral, "#cli"
    element :btn_ver, "#btn_cli"
    element :veiculoMapa, :xpath, "//div[@id='map-canvas']/div[@class='leaflet-map-pane']/div[@class='leaflet-objects-pane']/div[@class='leaflet-marker-pane']/div[@class='awesome-marker-icon-red awesome-marker leaflet-zoom-animated leaflet-clickable']"
    element :clienteMapaGeral, :xpath, "//div[@class='ft-marker-details']/div[@class='info-marker'][2]/span/strong"
    element :cercaMapaGeral, :xpath, "/html/body/section[@id='dimensao-mapa-geral']/div[@class='row']/div[@class='col-md-12']/div[@id='map-canvas']/div[@class='leaflet-control-container']/div[@class='leaflet-top leaflet-left']/div[@class='leaflet-draw leaflet-control']/div[@class='leaflet-draw-section'][1]/div[@class='leaflet-draw-toolbar leaflet-bar leaflet-draw-toolbar-top']/a[@class='leaflet-draw-draw-polygon']"
    

    # mapa Geral v2 
    element :selectClientes, "#clientes"
    element :selectRastreados, "#rastreados"
    element :setinhaAcima, "#topNavButton"
    element :setinhaAbaixo, "#bottomNavButton"
    element :inputMapageral2, :xpath, "//div[@class='fixed-table-toolbar']/div[@class='pull-right search input-group']/input[@class='form-control search-input']"
    element :clienteGridMapa2, "/html/body/div[@id='bottomNav']/div[@class='bootstrap-table bootstrap3']/div[@class='fixed-table-container fixed-height']/div[@class='fixed-table-body']/table[@id='gridRastreados']/tbody/tr/td[@class='gridRastreadosDescCliente']"

    # Dashboard
    element :inputDashboard, :xpath, "//div[@id='lista-clientes']/div[@id='tabela-clientes_wrapper']/div[@id='tabela-clientes_filter']/label/input"
    element :checkboxCli, :xpath, "//div[@id='lista-clientes']/div[@id='tabela-clientes_wrapper']/table[@id='tabela-clientes']/tbody/tr[@class='odd'][1]/td[@class='sorting_1']"
    element :btn_selecionar, "#exibir-rastreados-selecionados"
    element :btn_somente_selecionados, ".cancel"
    element :pontoMapaDash, :xpath, "//div[@class='leaflet-objects-pane']/div[@class='leaflet-marker-pane']/div[@class='awesome-marker-icon-red awesome-marker leaflet-zoom-animated leaflet-clickable']"
    element :cliMapaDash, :xpath, "//div[@class='leaflet-popup-content-wrapper']/div[@class='leaflet-popup-content']/div[@class='row']/div[@class='ft-marker-details']/div[@class='info-marker'][2]/span/strong"

    # Tela Area de Risco 
    element :clickMapaAreaRisco1, :xpath, "//div[@class='leaflet-tile-container leaflet-zoom-animated']/img[@class='leaflet-tile leaflet-tile-loaded'][4]"
    element :clickMapaAreaRisco2, :xpath, "//div[@class='leaflet-tile-container leaflet-zoom-animated']/img[@class='leaflet-tile leaflet-tile-loaded'][3]"
    element :clickMapaAreaRisco4, :xpath, "//div[@class='leaflet-marker-icon leaflet-div-icon leaflet-editing-icon leaflet-zoom-animated leaflet-clickable'][1]"

    # Cadastros de usuarios do sistema
    element :perfilPersonlizado, "a#perfil_personalizado"


end 