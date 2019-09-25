class Clientes < Elementos_clientes
    include Capybara::DSL
    include RSpec::Matchers

    def verificaNaGrid(stringPesquisa)
        select_by_attribute(variaveisMap('selectFlitro'),'id', 'ras_cli_desc')
        sleep(2)
        inputGrid.set(stringPesquisa)
        sleep(2)
        ordenacaoId.click()     
        sleep(2)
        @id = idGrid.text
        idGrid.click()
        return @id
    end
    
    def apagar_registros(registros)
        indice = 0
    
        find(:xpath, "//div[@id='clientes_length']/label/select/option[@value='100']").click()
    
        while indice < registros
    
            sleep(1)
            idGrid.click()
            Elementos_default.new.btn_excluir.click()
            expect(page.has_xpath?("/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")).to eq true
            Elementos_default.new.btn_confirm.click()
            sleep(1)
            @mensagem = find(:xpath, "/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']/p").text()
            verificarMensagens(@mensagem, "sucesso")
            sleep(2)
            Elementos_default.new.btn_confirm.click()
    
            indice += 1
        end
    end
    
    def verificaNaSelect(idCliente,nomeFantasia)
        indice = 0 
        @arrayTelas = [
            'cadastros/veiculo_controller/novo',
            'rastreadores/acesso_controller/novo',
            'oficina/novo',
            'cadastros/contato_controller',
            'app',
            'rastreados',
            'mapaGeral',
            'mapaGeral_v2',
            'dashboard_controller',
            'cadastroMotoristas/novo',
            'cadastros/ponto_referencia/novo',
            'cadastros/itinerario/novo',
            'cadastros/pessoas_controller/novo',
            'cadastros/outros/novo',
            'cadastros/manutencao_controller/novo',
            'cadastros/passageiroRfid/novo',
            'cadastros/area_risco_controller',
            'cadastros/categoria_cerca_controller/novo',
            'ultrasonico_combustivel/tanque_controller/novo',
            'cadastros/temperatura_controller/novo',
            'adapter_controller?url=logistica/veiculosproximos',
            'adapter_controller?url=logistica/monitoramento_itinerario',
            'relatorioitinerario/relatorioitinerario',
            'relatorios',
            'telemetria/pontuacao_infracao_controller/novo',
            'telemetria/rel_infracoes',
            'telemetria/graficos_infracoes',
            'cadastros/usuario_sistema_controller/novo',
            'cadastros/veiculos_sem_comunicacao_controller/novo',
            'configurar_integracao_controller/novo',
            
        ]
    
        while indice < @arrayTelas.length
            if @arrayTelas[indice] == 'relatorios' 
                relatorios(idCliente)           
            end

            @arrayTelas[indice] != 'app' ? entrarNaPaginaEspecifica(@arrayTelas[indice]) : iniciarApp()
            
            case @arrayTelas[indice]
            when 'cadastros/veiculo_controller/novo'
                cadVeiculo(idCliente,nomeFantasia,'Teste Cadastro Clientes')
            when 'rastreadores/acesso_controller/novo'
                cadRastreadores(idCliente,nomeFantasia)
            when 'oficina/novo'
                fazerOficina(idCliente,nomeFantasia)
            when 'cadastros/contato_controller'
                cadContato(idCliente,nomeFantasia)
            when 'rastreados'
                rasteados(idCliente,nomeFantasia)
            when 'mapaGeral'
                mapaGeral(idCliente,nomeFantasia)
            when 'mapaGeral_v2'
                mapaGeral_v2(idCliente,nomeFantasia)
            when 'dashboard_controller'
                dashboard(nomeFantasia)
            when 'cadastroMotoristas/novo'
                select_by_value('idCliente',idCliente)
                sleep(2)
            when 'app'
                verificarNoApp(nomeFantasia)
            when 'cadastros/ponto_referencia/novo'
                select_by_value('ras_ref_id_cli',idCliente)
                sleep(2)
            when 'cadastros/itinerario/novo'
                select_by_value('ras_iti_id_cliente',idCliente)
                select_by_value('ras_itv_id_veiculo',@descricaoVeiculo)
                sleep(2)
            when 'cadastros/pessoas_controller/novo'
                select_by_value('ras_cli_id',idCliente)
                sleep(2)
            when 'cadastros/outros/novo'
                select_by_value('ras_vei_id_cli',idCliente)
                sleep(2)
            when 'cadastros/manutencao_controller/novo'
                select_by_value('ras_cli_id',idCliente)
                sleep(2)
            when 'cadastros/passageiroRfid/novo'
                select_by_value('ras_pas_id_cli',idCliente)
                sleep(2)
            when 'cadastros/area_risco_controller'
                areaRisco(idCliente)
            when 'cadastros/categoria_cerca_controller/novo'
                evaluate_script("$('input#option2')[0].click()")
                select_by_value('select_cliente',idCliente)
            when 'ultrasonico_combustivel/tanque_controller/novo'
                select_by_value('idCliente', idCliente)
            when 'cadastros/temperatura_controller/novo'
                select_by_value("idCliente",idCliente)
            when 'adapter_controller?url=logistica/veiculosproximos'
                evaluate_script("$('#idCliente').val(#{@idCliente})")
                sleep(2)
            when 'adapter_controller?url=logistica/monitoramento_itinerario' 
                evaluate_script("$('#idCliente').val(#{@idCliente})")                
                evaluate_script("$('#idVeiculo').val(#{@descricaoVeiculo})")       
            when 'relatorioitinerario/relatorioitinerario'
                evaluate_script("$('#idCliente').val(#{@idCliente})")         
            when 'telemetria/pontuacao_infracao_controller/novo'
                select_by_value('ras_pon_id_cliente',idCliente)
            when 'telemetria/rel_infracoes'
                evaluate_script("$('#idCliente').val(#{@idCliente})")                
            when 'telemetria/graficos_infracoes'
                evaluate_script("$('#idCliente').val(#{@idCliente})")                
            when 'cadastros/usuario_sistema_controller/novo'
                perfilPersonlizado.click()
                sleep(2)
                select_by_value('selectCliente',idCliente) 
                sleep(2)
            when 'cadastros/veiculos_sem_comunicacao_controller/novo'
                select_by_value('ras_cfg_vei_sem_com_id_cliente', idCliente)
                sleep(2)
            when 'configurar_integracao_controller/novo'
                select_by_value('ras_cli_desc',idCliente)
                sleep(2)
            end
            indice += 1
        end
    end
    
    def selecionaEverifica(idCliente,nomeFantasia,idSelect)
        select_by_value(idSelect,idCliente)
        expect(page.has_text?(nomeFantasia)).to eq true
    end
    
    def selecionaClienteContato(cliente)
        sleep(3)
        pesquisaCliente.set(cliente)
        sleep(3)
        selecionaCliContato.click()
        sleep(3)
        moverCliente.click()
        adicionarContato.click()
    end
    
    def cadVeiculo(idCliente,nomeFantasia,NomeVeiculo)
        @valores = [NomeVeiculo,SecureRandom.hex(5),'1']
        selecionaEverifica(idCliente,nomeFantasia,'ras_vei_id_cli')
        preencheCampos(variaveisMap(['descricaoVeiculo',
            'placaVeiculo',
            'tipoVeiculo'
            ]),@valores)
    
        Elementos_default.new.btn_salvar.click()
        sleep(6)
        Elementos_default.new.btn_confirm.click()
        sleep(3)
        ordenacaoVeiculos.click()
        sleep(5)
        @descricaoVeiculo = idGridVeiculo.text()
        sleep(2)
    
    end
    
    def cadRastreadores(idCliente,nomeFantasia)
        @campos = variaveisMap(['IdEquipamento','fabricante','produto'])    
        @produto = "33"
        @valores = [SecureRandom.hex(6), '3', @produto]
        
        preencheCampos(@campos,@valores)
        Elementos_default.new.btn_salvar.click()
        sleep(3)
        Elementos_default.new.btn_confirm.click()
        sleep(2)
        ordenacaoAcesso.click()
        sleep(5)
        @equipamento = idgridAcesso.text
        produtoGridAcesso.click()
        sleep(5)
        puts @equipamento
        ativarRegistro.click()
        sleep(2)        
        Elementos_default.new.btn_confirm.click()
    end
    
    def fazerOficina(idCliente,nomeFantasia)
        selecionaEverifica(idCliente,nomeFantasia,'cliente')
    
        @campos = ['produto','rastreador','veiculo']
        @valores = [@produto,@equipamento,@descricaoVeiculo]
    
        preencheCampos(@campos,@valores)
    
        Elementos_default.new.btn_salvar.click()
        sleep(2)
        Elementos_default.new.btn_confirm.click()
        sleep(2)
        simularGps()
    end
    
    def cadContato(idCliente,nomeFantasia)
    
        select_by_attribute('filtros-servidor','id', 'ras_ccn_contato')
        find(:xpath, "//div[@id='table-contato_filter']/label/input").set('Lucas')
        sleep(4)
        find(:xpath, "//table[@id='table-contato']/thead/tr/th[@class='sorting_asc']").click()
        sleep(3)
        find(:xpath, "//table[@id='table-contato']/tbody/tr[@class='odd'][1]/td[@class='sorting_1']").click()
        sleep(4)
        Elementos_default.new.btn_editar.click()
        sleep(2)
        pesquisaCliente.set(nomeFantasia)
        sleep(2)
        selecionaCliContato.click()
        sleep(1)
        moverCliente.click()
        sleep(1)
        find(:xpath, "//div[@class='well']/div[@class='row']/div[@class='col-md-10']/div[@class='input-group']/input[@class='form-control']").set(nomeFantasia)
        sleep(2)
        find(:xpath, "//div[@id='clientes-selecionados']/div[@class='well']/ul[@class='list-group']/li[@class='list-group-item active']").double_click()
        sleep(2)
        find(:xpath, "//table[@id='tabela-veiculos']/tbody/tr[@class='par odd']/td[@class='sorting_1']").click()
        find_by_id('salvar-veiculos').click()
        sleep(2)
        Elementos_default.new.btn_salvar.click()
        sleep(3)
        Elementos_default.new.btn_confirm.click()   
    end
    
    def simularGps()
        visit 'http://fulltrack-tools.ftdata.com.br'
        loginFtTools()
        sleep(2)
        visit 'http://fulltrack-tools.ftdata.com.br/simuladorGps'
        select_by_value('id_monitoramento_select','7112')
        sleep(2)
        select_by_value('id_rastreado',@descricaoVeiculo)
        sleep(1)
        enviar_posicao.click()
        sleep(3)
    end
    
    def verificarNoApp(nomeFantasia)
        driver.find_element(:class, "android.widget.EditText").send_keys(@NomeVeiculo)
        @nomeCliente = driver.find_element(:xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]/android.view.ViewGroup/android.view.ViewGroup[2]/android.widget.HorizontalScrollView/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.widget.ScrollView/android.view.ViewGroup/android.view.ViewGroup[1]/android.view.ViewGroup[1]/android.widget.TextView")
        puts @nomeCliente.text
        sleep(6)
        expect(@nomeCliente.text).to eq nomeFantasia
    end
    
    def rasteados(idCliente, nomeFantasia)
        sleep(2)
        inputPesquisaRastresados.set('Teste Cadastro Clientes')
        sleep(5)
        ordenacaoRasteados.click()
        sleep(4)
        expect(page.has_css?('dataTables_empty')).to eq false
        expect(clienteRasteados.text).to eq "#{nomeFantasia} "
        select_by_value('filtros-clientes',idCliente)
        sleep(2)

        painelBordoMapa.click()
        sleep(3)

        @idCliente = idCliente
        cerca(@idCliente) 
    end
    
    def mapaGeral(idCliente,nomeFantasia)
        botaoPesquisa(5)
        puts 'aqui'
        sleep(3)
        consultasMap(2,'',idCliente,'')
        sleep(2)
        consultasMap(3,'',idCliente,'')
        sleep(2)
        consultasMap(4,'',idCliente,'')
    
        inputMapaGeral.set(nomeFantasia)
        btn_ver.click()

        sleep(4)

        veiculoMapa.click()
        sleep(3)
        expect(clienteMapaGeral.text).to eq nomeFantasia
    end

    def mapaGeral_v2(idCliente,nomeFantasia)
        setinhaAcima.click()
        sleep(2)
        select_by_value(variaveisMap('selectClientes'),idCliente)
        sleep(2)
        select_by_attribute(variaveisMap('selectRastreados'),'parentvalue',idCliente)
        sleep(2)
        select_by_value(variaveisMap('selectClientes'),0)
        sleep(2)
        setinhaAbaixo.click()        
        sleep(2)
        inputMapageral2.set(nomeFantasia)
        sleep(2)
        expect(find(:xpath, "/html/body/div[@id='bottomNav']/div[@class='bootstrap-table bootstrap3']/div[@class='fixed-table-container fixed-height']/div[@class='fixed-table-body']/table[@id='gridRastreados']/tbody/tr/td[@class='gridRastreadosDescCliente']").text).to eq nomeFantasia
        sleep(2)
        find(:xpath, "/html/body/div[@id='bottomNav']/div[@class='bootstrap-table bootstrap3']/div[@class='fixed-table-container fixed-height']/div[@class='fixed-table-body']/table[@id='gridRastreados']/tbody/tr/td[@class='gridRastreadosDescCliente']").click()
        sleep(4)
    end

    def dashboard(nomeFantasia)
        inputDashboard.set(nomeFantasia)
        sleep(4)
        checkboxCli.click()
        sleep(2)
        btn_selecionar.click()
        sleep(2)
        btn_somente_selecionados.click()
        sleep 2
        pontoMapaDash.click()
        sleep(3)
        expect(cliMapaDash.text).to eq nomeFantasia
        pontoMapaDash.click()
        sleep(2)

    end

    def cerca(idCliente)
        evaluate_script("$('.leaflet-draw-draw-polygon')[0].click()")
        sleep(4)
        click1noMapa.click()
        sleep(2)
        click2noMapa.click()
        sleep(2)
        click3noMapa.click()            
        sleep(2)
        click4noMapa.click()
        sleep(2)
        select_by_value("ras_rot_id_cliente", idCliente)
        sleep(2)
        select_by_value("contatos", '217414')
        sleep(2)
        select_by_value("ras_rot_id_veiculo",@descricaoVeiculo)
    end

    def areaRisco(idCliente)
        evaluate_script("$('.leaflet-draw-draw-polygon')[0].click()")
        sleep(4)
        clickMapaAreaRisco1.click()
        sleep 2
        clickMapaAreaRisco2.click()
        sleep 2
        page.driver.browser.action.move_to(page.find('svg.leaflet-zoom-animated').native).click.perform
        sleep 2
        clickMapaAreaRisco4.click()
        sleep(2)

        select_by_value('ras_cer_id_cliente',idCliente)
        sleep 2
    end

    def relatorios(idCliente)
        indice = 1
        while indice < 26
            sleep(2)
            find(".ft-menu-toggle").click()
            sleep(2)
            find("a[href='#menu4']").click()        
            sleep(2)
            
            evaluate_script("$('#idCliente').val(#{@idCliente})")
            sleep(2)
    
            find(:xpath, "//ul[@id='menu4']/li[#{indice}]/a[@class='item-menu']").click()
            indice +=1
        end
        sleep(2)
    end

end