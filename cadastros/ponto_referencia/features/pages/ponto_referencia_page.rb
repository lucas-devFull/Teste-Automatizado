class Ponto_referencia < Elementos_ponto_referencia
    include Capybara::DSL
    include RSpec::Matchers

    def preencherCampoMapa(endereço)
        wait_for_ajax
        pesquisaMapa.set(endereço)
        sleep(2)
        pesquisaMapa.send_keys  :down
        pesquisaMapa.send_keys  :enter
    end    

    def preencherCampos(campos)
        @descricao = 'Téste Novínho'
        find_by_id(campos[0]).set(@descricao)
        select_by_value(campos[1],'2')
        sleep(2)
        if verificaUsuarioFinal() == false
            select_by_value(campos[2],campos[3])
        end        
        return @descricao
    end

    def apagaDados(campos)
        for i in campos do
            find_by_id(i).set(' ')            
        end
    end

    def selecionarIcone(icone)
        if page.has_css?("#iframe_map")
            within_frame('iframe_map') do
                wait_for_ajax
                find(:xpath, "//div/img[@class='imgpontoref'][#{icone}]").click()
            end
        else
            wait_for_ajax
            find(:xpath, "//div/img[@class='imgpontoref'][#{icone}]").click()
        end
    end

    def verificarNaGrid(stringPesquisa)
        sleep(2)
        gridPesquisa.set(stringPesquisa)
        sleep(2)
        ordenacaoAsc.click()
        sleep 1
        ordenacaoDesc.click()
        sleep 1
        gridPesquisa.set(idGrid.text)
        return idGrid.text
    end

    def verificaCamposPreenchidos(campos,valores)
        indice = 0
        while indice < valores.length
            if campos[indice] == 'abrir_modal'
                expect(valores[indice]).to eq evaluate_script( "$('#" + campos[indice] + "').attr('#{(campos[indice] == 'abrir_modal') ? "data-nome-icon" : "value"}')")
            elsif campos[indice] == 'cad-pointer'
                expect(valores[indice]).to eq evaluate_script( "$('#" + campos[indice] + "').attr('#{(campos[indice] == 'cad-pointer') ? "data-nome-icon" : "value"}')")
            end

            indice += 1
        end
    end

    def consultaPontoInput(url,selectCliente,cliente,inputPonto,ponto,acao)
        visit "#{CONFIG['url_padrao']}/#{url}"
        wait_for_ajax
        if page.has_css?("#ras_iti_id_cliente")
            find_by_id(selectCliente).select(cliente)
            inputDesc.set("teste")
            select_by_value("ras_itv_id_veiculo","45048")
            btn_proximo.click()
            sleep(2)
            if acao == "cadastro"
                select_by_value(inputPonto,ponto)
            end
        elsif page.has_css?("#descricaoPonto")
            find_by_id(inputPonto).set(ponto)
            gerarRelatorio.click()
        elsif page.has_css?('#idPontoRefAutoComplete')
            evaluate_script("$('#idCliente').val('22647')")
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
                select_by_value("ras_cli_id_busca",'22647')
            else
                evaluate_script(script)
            end
            find(inputPonto).set(ponto)
            sleep(3)
            find(inputPonto).send_keys(:down)
            find(inputPonto).send_keys(:down)
            find(inputPonto).send_keys(:enter)
        end
    end

    def selecionarRegistro(stringPesquisa)
        wait_for_ajax
        gridPesquisa.set(stringPesquisa)
        wait_for_ajax
        sleep 2
        ordenacaoAsc.click()
        sleep(1)
        ordenacaoDesc.click()
        wait_for_ajax
        gridPesquisa.set(idGrid.text)
        sleep(2)
        idGrid.click()
        return idGrid.text
    end

    def verificaExclusao(caminho,id)
        if page.has_css?('#iframe_map')
            within_frame('iframe_map') do
                expect(page.has_no_xpath?("//select[@id='#{caminho}']/option[@value='#{id}']")).to eq  true
            end
        else
            expect(page.has_no_xpath?("//select[@id='#{caminho}']/option[@value='#{id}']")).to eq  true
        end
    end

    def verificaCadastro(caminho,id,desc)
        if page.has_css?('#iframe_map')
            within_frame('iframe_map') do
                expect(find_by_id(caminho).value).to eq id
                if find_by_id(caminho).value == id
                    expect(find("span#select2-ponto-ref-lista-container").text()).to eq desc
                end
            end
        else
            expect(find_by_id(caminho).value).to eq id
            if find_by_id(caminho).value == id
                expect(find("span#select2-ponto-ref-lista-container").text()).to eq desc
            end
        end
    end

    def verificaConsulta(caminho,acao,id,desc)
        if acao == "cadastro"
            verificaCadastro(caminho,id,desc)
        elsif acao == "exclusao"
            verificaExclusao(caminho,id)
        end        
    end

    def verificaConsultaPF(acao,desc)
        if acao == "cadastro"
            expect(descGrid.text).to eq desc
        elsif acao == "exclusao"
            expect(page.has_css?(".no-records-found")).to eq true
          end        
    end

    def verificaTipoPonto(caminho,id,desc,acao)
        if acao == 'cadastro'
            if caminho == "ras_ref_tipo"
                expect(text_select_tipo_ponto.text).to eq desc
            else
                expect(text_select_tipo_ponto_telaAssociada.text).to eq desc
            end
        elsif acao == 'exclusao'
            verificaExclusao(caminho ,id)
        end
    end

    def verificaPopUp()
        expect(page).to have_xpath("//div[@role='tooltip']")
    end
end