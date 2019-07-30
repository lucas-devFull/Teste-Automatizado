class Ponto_referencia < SitePrism::Page
    include Capybara::DSL
    include RSpec::Matchers

    set_url "#{CONFIG['url_login']}"

    element :botao_novo, "#add"
    element :botao_salvar, :xpath, "//button[@class='btn btn-success btn-salvar ladda-button']"
    element :botao_salvar_continuar_registrando, :xpath, "//div[@class='btn-group open']/ul[@id='btn-form']/li/a[@class='btn-salvar btn-secundario ladda-button border0']"

    element :descricao, "#ras_ref_descricao"
    element :cliente, '#ras_ref_id_cli'
    element :cidade, '#ras_ref_cidade'
    element :estado, '#ras_ref_uf'
    element :pais, '#ras_ref_pais'
    element :tipo, '#ras_ref_tipo' 
    element :pesquisaMapa, '#end-do-mapa'
    element :autocomplete, :xpath, "//div[@class='autocomplete-suggestions ']/div[@class='autocomplete-suggestion']"

    element :gridPesquisa, :xpath, "//div[@class='bootstrap-table']/div[@class='fixed-table-toolbar']/div[@class='pull-right search']/input[@class='form-control']"
    element :ordenacao, :xpath, "//table[@id='bootstrap-table']/thead[@class='dark-thead']/tr/th[2]/div[@class='th-inner sortable both']"
    element :idGrid, :xpath, "//div[@class='bootstrap-table']/div[@class='fixed-table-container']/div[@class='fixed-table-body']/table[@id='bootstrap-table']/tbody/tr[1]/td[2]"
    element :descGrid, :xpath, "//div[@class='bootstrap-table']/div[@class='fixed-table-container']/div[@class='fixed-table-body']/table[@id='bootstrap-table']/tbody/tr[1]/td[4]"

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
    element :marker_mapa, :xpath, "//div[@class='awesome-marker-icon-red awesome-marker leaflet-zoom-animated leaflet-clickable']"
    element :opcao_ponto, :xpath, "//div[@id='home']/a[@class='btn btn-default btn-relatorios cadastropr']"


    def preencherCampoMapa(endereço)
        wait_for_ajax
        pesquisaMapa.set(endereço)
        sleep(4)
        pesquisaMapa.send_keys  :down
        pesquisaMapa.send_keys  :enter
    end    

    def preencherCampos(campos)
        @descricao = 'Féito péçlo painel de Bôrdó'
        find_by_id(campos[0]).set(@descricao)
        select_by_value(campos[1],'2')
        sleep(2)
        # if campos.include?('#ras_ref_id_cli')
            select_by_value(campos[2],campos[3])
        # end        
        return @descricao
    end

    def apagaDados(campos)
        for i in campos do
            find(i).set(' ')            
        end
    end

    def selecionarIcone(icone)
        wait_for_ajax
        find(:xpath, "//div/img[@class='imgpontoref'][#{icone}]").click()
    end

    def verificarNaGrid(stringPesquisa)
        wait_for_ajax
        gridPesquisa.set(stringPesquisa)
        wait_for_ajax
        ordenacao.click()
        wait_for_ajax
        gridPesquisa.set(idGrid.text)
        return idGrid.text
    end

    def verificaCamposPreenchidos(campos,valores)
        indice = 0
        while indice < valores.length
            expect(valores[indice]).to eq find(campos[indice]).value            
            indice += 1
        end
        
    end

    def consultaPontoInput(url,selectCliente,cliente,inputPonto,ponto)
        visit "#{CONFIG['url_padrao']}/#{url}"
        wait_for_ajax
        if page.has_css?("#ras_iti_id_cliente")
            find_by_id(selectCliente).select(cliente)
            inputDesc.set("teste")
            select_by_value("ras_itv_id_veiculo","148747")
            btn_proximo.click()
            select_by_value(inputPonto,ponto)

        elsif page.has_css?("#descricaoPonto")
            find_by_id(inputPonto).set(ponto)
            gerarRelatorio.click()
        elsif page.has_css?('#idPontoRefAutoComplete')
            evaluate_script("$('#idCliente').val('15931')")
            find_by_id(inputPonto).set(ponto)
            sleep 2
            find_by_id(inputPonto).send_keys(:up)
            find_by_id(inputPonto).send_keys(:enter)
        end

    end

    def consultaComIframe(url,script,inputPonto,ponto) 
        visit "#{CONFIG['url_padrao']}/#{url}"
        wait_for_ajax
        within_frame('iframe_map') do
            if url == "adapter_controller?url=logistica/logisticaitinerario"
                select_by_value("ras_cli_id_busca",'15931')
            else
                evaluate_script(script)
            end
            find(inputPonto).set(ponto)
            wait_for_ajax
            find(inputPonto).send_keys(:down)
            find(inputPonto).send_keys(:down)
            find(inputPonto).send_keys(:enter)
        end
    end
end