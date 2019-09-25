class Elementos_ponto_referencia < SitePrism::Page

    set_url "#{CONFIG['url_teste']}"

    def variaveisMap(var)
        variaveis = {
            :selectCliente => 'cliente-ponto-referencia-mapa',
            :selectTipoPonto => 'tipo-ponto',
            :selectTipoPontoRelPerPon => 'idPontoTipoRef',
        }
        return variaveis[:"#{var}"]
    end
    
    # botões
    element :botao_novo, "#add"
    element :botao_salvar, :xpath, "//button[@class='btn btn-success btn-salvar ladda-button']"
    element :botao_salvar_continuar_registrando, :xpath, "//div[@class='btn-group open']/ul[@id='btn-form']/li/a[@class='btn-salvar btn-secundario ladda-button border0']"
    element :btn_excluir, "#remove"
    element :btn_editar, "#edit"
    element :btn_excluirPonto_modal, ".btn-excluir-ponto"
    element :add_ponto, "#btn_abrir_popup"
    element :btn_salvar_tipo, "#btn_salvar_tipo"
    element :btn_cancelar_tipo, ".btn-cancelar"
    element :novo_tipo_telaAssociada, "#btn-novo-tipo-ponto"
    element :confirma_novo_tipo_telaAssociada, "#btn-salvar-tipo-ponto"
    element :deletar_tipo_referencia, "#btn_deletar_popup"
    element :deletar_tipo_referencia_telaAssociada, "#btn-excluir-tipo-ponto"
    element :btn_editar_popup, "#btn_editar_popup"
    
    element :descricao, "#ras_ref_descricao"
    element :cliente, '#ras_ref_id_cli'
    element :cidade, '#ras_ref_cidade'
    element :estado, '#ras_ref_uf'
    element :pais, '#ras_ref_pais'
    element :tipo, '#ras_ref_tipo' 
    element :pesquisaMapa, '#end-do-mapa'
    element :autocomplete, :xpath, "//div[@class='autocomplete-suggestions ']/div[@class='autocomplete-suggestion']"

    # grid
    element :gridPesquisa, :xpath, "//div[@class='fixed-table-toolbar']/div[@class='pull-right search input-group']/input[@class='form-control search-input']"
    element :ordenacaoAsc, :xpath, "//table[@id='bootstrap-table']/thead[@class='dark-thead thead-dark']/tr/th[2]/div[@class='th-inner sortable both']"
    element :ordenacaoDesc, :xpath, "//table[@id='bootstrap-table']/thead[@class='dark-thead thead-dark']/tr/th[2]/div[@class='th-inner sortable both asc']"
    element :idGrid, :xpath, "//table[@id='bootstrap-table']/tbody/tr[1]/td[2]"
    element :descGrid, :xpath, "//table[@id='bootstrap-table']/tbody/tr[1]/td[4]"

    # mapa - Telas associadas
    element :zoomIn, "a.leaflet-control-zoom-in"
    element :ponto_mapa, :xpath, "//div[@class='leaflet-map-pane']/div[@class='leaflet-objects-pane']/div[@class='leaflet-marker-pane']/img[@class='leaflet-marker-icon leaflet-zoom-animated leaflet-clickable']"

    # input e selects
    element :inputDescMapa, "#observacao-ponto-referencia-mapa"
    element :selectPonto, "#ponto-ref-lista"
    element :input_tipo_ponto, ".desc_tipo"
    element :input_novo_tipo_tela_ass, "#desc-novo-tipo-ponto"
    element :text_select_tipo_ponto, "#select2-ras_ref_tipo-container"
    element :text_select_tipo_ponto_telaAssociada, :xpath, "//select[@id='tipo-ponto']/option[@selected]"
    element :input_editar_tipo_referencia, ".desc_tipo"
    
    # relatorio Ponto de referencia
    element :gerarRelatorio, "#gerar_relatorio"

    #  cadastro itinerario
    element :inputDesc, "#ras_iti_descricao"
    element :selectVeiculo, "#ras_itv_id_veiculo"
    element :btn_proximo, ".next-step"

    # mapa Painel de Bordo
    element :btn_ponto, :xpath, "//a[@class='leaflet-draw-draw-marker']"
    element :opção_mapa, :xpath, "/html/body/section[@class='ft-centerbox ft-menu-plus270px']/div[@id='painel_bordo_id']/div[@class='row ft-zero-margin-row set-fix-height-responsive totais']/div[@class='col-md-8 ft-zero-padding-row box-info']/div[@class='ft-topbox-dashboard map-tamanho-painel-bordo']/div[@id='map-canvas']/div[@class='leaflet-map-pane']/div[@class='leaflet-tile-pane']/div[@class='leaflet-layer']/div[@class='leaflet-tile-container leaflet-zoom-animated']/img[@class='leaflet-tile leaflet-tile-loaded'][1]/@src"
    element :btn_criar, ".btn-finalizar-ponto"
    element :marker_mapa, :xpath, "//div[@class='awesome-marker-icon-red awesome-marker leaflet-zoom-animated leaflet-clickable'][1]"
    element :opcao_ponto, :xpath, "//div[@id='home']/a[@class='btn btn-default btn-relatorios cadastropr']"

    # mapa geral
    element :inputPlaca, "#placa"
    element :btn_placa, "#btn_placa"

    # Dashboard 
    element :cluster1, :xpath, "//div[@class='leaflet-top leaflet-left']/div[@class='leaflet-bar leaflet-control'][1]/a[@class='leaflet-bar-part']"
    element :cluster2, :xpath, "//div[@class='leaflet-marker-pane']/div[@class='leaflet-marker-icon marker-cluster marker-cluster-medium leaflet-zoom-animated leaflet-clickable']/div"
    element :cluster3, :xpath, "//div[@class='leaflet-marker-pane']/div[@class='leaflet-marker-icon marker-cluster marker-cluster-medium leaflet-zoom-animated leaflet-clickable']/div"
    element :pontoDashboard, :xpath, "//div[@class='awesome-marker-icon-red awesome-marker leaflet-zoom-animated leaflet-clickable'][2]" 

end