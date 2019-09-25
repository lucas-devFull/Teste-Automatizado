class Acesso < Elementos_acesso
    include Capybara::DSL
    include RSpec::Matchers

    def preencheCampos(campos, valores)
        indice = 0
        while indice < campos.length
            if evaluate_script("document.getElementById('#{campos[indice]}').tagName") == 'SELECT'
                sleep(1)
                select_by_value(campos[indice],valores[indice])
                puts select_by_value(campos[indice],valores[indice])
            elsif evaluate_script("document.getElementById('#{campos[indice]}').tagName") == 'INPUT'
                find_by_id(campos[indice]).set(valores[indice])
            end
            indice += 1
        end
    end

    def verificaConfiguracao()
        for i in listaFabricante do
            select_by_value(variaveisMap('fabricante'),i.value)
            sleep 1
            for j in listaProdutos do
                # p j.value            
                if j.value == "0" || j.value == "34" || j.value == "178"                
                    # p j.text()
                else
                    select_by_value(variaveisMap('produto'),j.value)
                    sleep(1)
                    chaveConfiguracao.click()
                    if page.has_xpath?("//div[@id='config_popup']/div[@id='porta']/span[@class='config_estilizadas']") == true
                        wait_for_ajax
                        sleep(1)
                        expect(page.has_xpath?("//div[@id='config_popup']/div[@id='porta']/span[@class='config_estilizadas']")).to eq true
                        chaveConfiguracao.click()

                    elsif page.has_xpath?("//div[@id='config_popup']/div[@id='porta']/span[@class='config_estilizadas']") == false
                        wait_for_ajax
                        chaveConfiguracao.click()
                        puts "erro"
                        p j.text()
                    end 
                end 
            end
        end
    end

    def verificaNaGrid(id)
        select_by_attribute(variaveisMap('selectFlitro'),'id', 'ras_ras_id_aparelho')
        sleep(2)
        inputPesquisa.set(id)
        sleep(2)
        ordenacao.click()
        idGrid.click()
    end

    def verificaNaSelect(page,id)
        if page == "oficina/novo"
            select_by_value(variaveisMap('rastreadorOficina'),id)
            expect(selectRastreadorOfic.value).to eq id
        elsif page == "cadastros/veiculo_controller/novo"
            select_by_value(variaveisMap('rastreadorCadVeiculo'),id)
            expect(selectRastreadorCadVei.value).to eq id
        end
    end

    def verificarCamposPreenchidos(campos,valores)
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
end