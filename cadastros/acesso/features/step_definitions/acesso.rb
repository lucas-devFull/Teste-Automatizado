Dado("o login no sistema") do
    elementos_acesso.load()
    loginSistema()
end
  
Quando("entro na pagina") do
    elementos_acesso.btn_acesso.click()
end

Quando("clico em adicionar") do
    elementos_default.botao_adicionar.click()
end
  
Entao("a pagina é redirecionada para o formulario de cadastro") do
    expect(page.has_css?('input#pesquisa_produto')).to eq true
end

Entao("clico em cancelar") do
    elementos_default.botao_cancelar.click()    
end
  
Entao("deve ser exibido o elemento de alerta cancelar") do

end
  
Então("clico em {string}") do |string|

end

Então("retorno para a grid") do
    sleep(2)
    expect(page.has_css?('.dataTables_wrapper')).to eq true
end

Quando("adiciono o fabricante {string}, a operadora {string}, o numero do chip {string}, IMEI {string}") do |string, string2, string3, string4|
    @campos = elementos_acesso.variaveisMap(['fabricante','operadora','numChip','imei'])
    @valores = [string,string2,string3,string4]
    acesso.preencheCampos(@campos,@valores)
end

Quando("clico em salvar") do
    sleep(6)
    elementos_default.btn_salvar.click()
end

Entao("os campos de Produtos e ID equipamento serão obrigatórios") do
    expect(page).to have_xpath("//div[@id='ras_ras_prd_id']/ul/li")
    expect(page).to have_xpath("//div[@id='ras_ras_id_aparelho']/ul/li")
end

Quando("adiciono o ID do equipamento {string}, o fabricante {string} e o produto {string}") do |equipamento,  fabricante, produto|
    @campos = [elementos_acesso.variaveisMap('IdEquipamento'),elementos_acesso.variaveisMap('fabricante'),elementos_acesso.variaveisMap('produto'),acesso.variaveisMap('imei')]    
    @valores = [equipamento, fabricante, produto]
    acesso.preencheCampos(@campos,@valores)
end

Entao("deve ser exibido o elemento de alerta sucesso") do
    wait_for_ajax
    expect(page).to have_xpath("/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")
end

Entao("deve ser exibida mensagem de sucesso") do
    sleep(1)
    @mensagem = find(:xpath, "/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']/p").text()
    verificarMensagens(@mensagem,'sucesso')
    elementos_default.btn_confirm.click()
end

Quando("verifico se todos os equipamentos e produtos tem informações de configuração") do
    @naoTemChavinha = {}
    @naoTemInformação = {}
    @semChave = []
    @semInfo = []
    @infoFabri = []
    @infoProd = []
    @chaveFabri = []
    @chaveProd = []

    for i in elementos_acesso.listaFabricante do
        select_by_value(elementos_acesso.variaveisMap('fabricante'),i.value)
        sleep 1
        for j in elementos_acesso.listaProdutos do
            p j.value            
            if j.value == "0" || j.value == "34" || j.value == "178"                
                p j.text()
            else
                select_by_value(elementos_acesso.variaveisMap('produto'),j.value)
            
                if page.have_xpath("//span[@id='ip_porta']/i[@class='fa fa-key']") == false
                    @chaveFabri << i.text()
                    @chaveProd << j.text()
                    @semChave = "#{@chaveFabri} / #{@chaveProd}" 
                end
                
                if page.has_css?(".glyphicon-question-sign") == false
                    @infoFabri << i.text()
                    @infoProd << j.text()
                    @semInfo = "#{@infoFabri} / #{@infoProd}"
                end
            end 
        end
    end

    @naoTemInformação = {
        :fabricante_produtos => @semInfo
    }

    p @naoTemInformação
   
    @naoTemChavinha = {
        :fabricante_produtos => @semChave
    }

    p @naoTemChavinha
end

Entao("seleciono todos os equipamentos verificando as configurações do produto") do
    acesso.verificaConfiguracao()
end

Quando("pesquiso um produto {string}") do |produto|
    elementos_acesso.pesquisa_produto.set(produto)
    # elementos_acesso.pesquisa_produto.send_keys(:down)
    elementos_acesso.pesquisa_produto.send_keys(:enter)
end

Quando("os campos fabricante e produto devem ser preenchidos automaticamente com os valores {string} e {string}") do |fabricante, produto|
    wait_for_ajax
    # sleep(1)
    expect(fabricante).to eq elementos_acesso.selectFabricante.value
    expect(produto).to eq elementos_acesso.selectProduto.value
end

Quando("preencho o restante dos campos {string}, {string}, {string}, {string}, {string}, {string}") do |string, string2, string3, string4, string5, string6|
    @campos = elementos_acesso.variaveisMap(['operadora','IdEquipamento','numChip','linha','imei','etiqueta'])
    @valores = [string, string2, string3, string4, string5, string6]
    acesso.preencheCampos(@campos, @valores)
end

Quando("se for selecionado o produto {string}, seleciono {string}") do |produto, opcao|
    if find(:xpath, "//select[@id='ras_ras_prd_id']/option[@selected]").text() == produto && produto == "F/Cell" 
        select_by_value(elementos_acesso.variaveisMap('selectFcell'),opcao)    
    elsif find(:xpath, "//select[@id='ras_ras_prd_id']/option[@selected]").text() == produto && produto == "LMU 2630/2720"
        evaluate_script('$("label[for=ras_ras_rede_can]").click()')
    else 
        p 'saiu de tudo e todos'
    end

end

Quando("verifico se o registro aparece na grid {string}") do |idEquipamento|
    sleep(2)
    acesso.verificaNaGrid(idEquipamento)
    sleep(2)
    expect(elementos_acesso.idEquipamentoGrid.text()).to eq idEquipamento
end

Dado("ativo o registro") do
    elementos_acesso.ativarRegistro.click()
    sleep(4)
end

Quando("eu seleciono o equipamento {string}") do |equipamento|
    select_by_attribute(elementos_acesso.variaveisMap('selectFlitro'),'id', 'ras_ras_id_aparelho')
    sleep(2)
    elementos_acesso.inputPesquisa.set(equipamento)
    # sleep(2)
    # elementos_acesso.ordenacaoAtivo.click()
    # sleep(2)
    # elementos_acesso.ordenacaoAtivoAsc.click()
    sleep(4)
    @id = elementos_acesso.idGrid.text
    elementos_acesso.idEquipamentoGrid.click()
    @idEquipamento = elementos_acesso.idEquipamento.text
    @quantidade_registros =  all(:xpath, "//table[@id='cadastro-acesso']/tbody/tr").length
end

Quando("eu entro na pagina {string}") do |page|
    @page = page
    entrarNaPaginaEspecifica(page)
end

Entao("verifico se o produto cadastrado está na opção de seleção") do
    sleep(5)
    acesso.verificaNaSelect(@page,@id)
end
    
Quando("vinculo um equipamento a um veiculo no cadastro de {string} com o {string} e o {string}") do |page,produto,veiculo|
    if page == "oficina"
        @campos = elementos_acesso.variaveisMap(['clienteOficina','produtoOficina','veiculoOficina','rastreadorOficina'])
        @valores = ['22647',produto,veiculo,@id]
    elsif page == "cadVeiculo"
        @campos = elementos_acesso.variaveisMap(['clienteCadVei','inputDescricaoCadVei','inputPlacaCadVei','tipoCadVeiculo','rastreadorCadVeiculo'])
        @valores = ['22647',"teste vinculo oficina",SecureRandom.hex(6),'1',@id]
    end
    acesso.preencheCampos(@campos,@valores)
end
  
Quando("verifico se o produto não está na opção de seleção {string}") do |page|
    expect(has_xpath?("//select[@id='#{ (page == 'oficina') ? elementos_acesso.variaveisMap("rastreadorOficina") : elementos_acesso.variaveisMap('rastreadorCadVeiculo') }']/option[@value='#{@id}']")).to eq false
end
  
Quando("pesquiso o equipamento") do
    select_by_attribute(elementos_acesso.variaveisMap('selectFlitro'),'id', 'ras_ras_id_aparelho')
    elementos_acesso.inputOficina.set(@idEquipamento)

end
  
Quando("verifico se ele está instalado") do
    sleep(2)
    elementos_acesso.ordenacaoStatus.click()
    sleep(2)
    expect(elementos_acesso.statusOficina.text).to eq  "Instalado"
    elementos_acesso.statusOficina.click()
end
  
Entao("clico em desvincular") do
    sleep(2)
    elementos_default.btn_excluir.click()
end

Entao("deve ser exibido o elemento de confirmação de exclusao") do
    wait_for_ajax
    expect(page).to have_xpath("/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")
  end
  
  Entao("devo clicar em {string}") do |string|
    if string == "sim"
        elementos_default.btn_confirm.click()
    elsif string == "nao"
        elementos_default.btn_cancel.click()
    end
  end

Quando("eu pesquiso um registro {string}") do |equipamento|
    @IdEquipamento = equipamento
    select_by_attribute(elementos_acesso.variaveisMap('selectFlitro'),'id', 'ras_ras_id_aparelho')
    elementos_acesso.inputPesquisa.set(equipamento)
    sleep(2)
    @quantidade_registros =  all(:xpath, "//table[@id='cadastro-acesso']/tbody/tr").length
end

Quando("ativo todos os registros") do
    
indice = 1
    while indice <= @quantidade_registros do
        # @acessosLivres = elementos_acesso.acessosLivres.text()
        # @acessosUtilizados = elementos_acesso.acessosUtilizados.text()

        sleep(2)
        find(:xpath, "//table[@id='cadastro-acesso']/tbody/tr[#{indice}]").click()
        elementos_acesso.ativarRegistro.click()
        sleep(2)
        elementos_default.btn_confirm.click()
        sleep(1)
        find(:xpath, "//table[@id='cadastro-acesso']/tbody/tr[#{indice}]").click()

        select_by_attribute(elementos_acesso.variaveisMap('selectFlitro'),'id', 'ras_ras_id_aparelho')
        elementos_acesso.inputPesquisa.set(@IdEquipamento)
    
        sleep(3)
        # @acessosUtilizados = @acessosUtilizados.to_i() + 1
        # @acessosLivres = @acessosLivres.to_i() - 1
        # expect(elementos_acesso.acessosLivres.text.to_i()).to eq(@acessosLivres)
        # expect(elementos_acesso.acessosUtilizados.text.to_i()).to eq(@acessosUtilizados)
        indice += 1
    end
end

Entao("nao podera ter mais de um registro ativo") do
    expect(has_xpath?("//table[@id='cadastro-acesso']/tbody/tr[2]/td[2]/font[@color='green']")).to eq false
end

Entao("verifico se os acessos livres foram diminuidos e os utilizados aumentados") do
    # verifico acima 
end

Quando("o registro estiver ativo") do
    expect(page.has_xpath?("//table[@id='cadastro-acesso']/tbody/tr[1]/td[2]/font[@color='green']")).to eq true
        
    
end

Quando("clico em excluir") do
    @acessosLivres = elementos_acesso.acessosLivres.text.to_i()
    puts @acessosLivres
    @acessosUtilizados = elementos_acesso.acessosUtilizados.text.to_i()
    puts @acessosUtilizados
    elementos_default.btn_excluir.click()
    sleep(2)
end

Entao("deve ser exibida a mensagem de alerta") do
    sleep(3)
    @mensagem = find(:xpath, "/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']/p").text
    verificarMensagens(@mensagem,'alerta')
    elementos_default.btn_confirm.click()
end

Quando("verifico se tem oficina") do
    expect(has_xpath?("//table[@id='cadastro-acesso']/tbody/tr[1]/td[3]/font[@color='green']")).to eq true
end
  
Quando("clico em desativar") do
    elementos_acesso.desativarRegistro.click()
end

Quando("o registro estiver desativado") do
    expect(find("#cadastro-acesso").has_xpath?("//table[@id='cadastro-acesso']/tbody/tr[1]/td[3]/font[@color='red']")).to eq true
    expect(find("#cadastro-acesso").has_xpath?("//table[@id='cadastro-acesso']/tbody/tr[1]/td[2]/font[@color='red']")).to eq true
end

Entao("verifico se o registro está desvinculado") do
    select_by_attribute(elementos_acesso.variaveisMap('selectFlitro'),'id', 'ras_ras_id_aparelho')
    elementos_acesso.inputOficina.set(@idEquipamento)
    expect(elementos_acesso.statusOficina.text).to eq 'Desinstalado'
    elementos_acesso.ordenacaoStatus.click()
    elementos_acesso.ordenacaoStatusAsc.click()
end

Entao("verifico se o registro está desativado na grid") do
    acesso.verificaNaGrid(@idEquipamento)
    sleep(2)
    elementos_acesso.ordenacaoAtivo.click()
    expect(find("#cadastro-acesso").has_xpath?("//table[@id='cadastro-acesso']/tbody/tr[1]/td[2]/font[@color='red']")).to eq false
    
end

Quando("verifico se o registro nao aparece na grid {string}") do |string|
    select_by_attribute(elementos_acesso.variaveisMap('selectFlitro'),'id', 'ras_ras_id_aparelho')
    elementos_acesso.inputPesquisa.set(string)
    expect(find("#cadastro-acesso").has_css?('.dataTables_empty')).to eq true

end

Quando("o registro estiver com oficina") do
    indice = 1
    while indice < @quantidade_registros         
        puts indice
        if has_xpath?("//table[@id='cadastro-acesso']/tbody/tr[1]/td[#{indice}]/font[@color='green']")
            expect(has_xpath?("//table[@id='cadastro-acesso']/tbody/tr[1]/td[3]/font[@color='green']")).to eq true    
            elementos_acesso.idEquipamento.click()
        else
            'So tem vermelin '
        end      
        indice +=1  
    end
end

Quando("verifico se o registro aparece na grid de oficina {string}") do |string|
    elementos_acesso.inputPesquisa.set(string)
    expect(page.has_xpath?("//table[@id='table-oficina']/tbody/tr[@data-id='#{@id}']/td[1]")).to eq true  
end

Quando("clico em editar") do
    elementos_default.btn_editar.click()
end
  
Quando("altero os campos") do
    @campos = elementos_acesso.variaveisMap(['numChip','linha','imei','etiqueta'])
    @aleatorioChip = SecureRandom.hex(6)
    @aleatorioLinha = SecureRandom.hex(8)
    @aleatorioImei = SecureRandom.hex(5)
    @valores = [@aleatorioChip, @aleatorioLinha, @aleatorioImei, '4']
    acesso.preencheCampos(@campos, @valores)

end
  
Entao("verifico o registro na grid") do
    sleep(2)
    elementos_acesso.inputPesquisa.set(@id)
    sleep(2)
    elementos_acesso.idGrid.click()
    expect(elementos_acesso.idEquipamentoGrid.text()).to eq @idEquipamento
end
  
Entao("os campos estarao editados") do 
    @campos = elementos_acesso.variaveisMap(['numChip','linha','imei','etiqueta'])
    @valores = [@aleatorioChip,@aleatorioLinha,@aleatorioImei,'4']
    sleep(1)
    acesso.verificarCamposPreenchidos(@campos,@valores)
    sleep(4)

end
  
Quando("verifico se os campos fabricante, produto, operadora e Id equipamento estão bloqueados") do
    indice = 0
    @arrayCampos = elementos_acesso.variaveisMap(['pesquisa_produto','fabricante','produto','IdEquipamento'])
    while indice < @arrayCampos.length do
         if select?(@arrayCampos[indice])
            expect(page.has_xpath?("//select[@disabled]")).to eq true
         else
            expect(page.has_xpath?("//input[@disabled]")).to eq true            
         end
        indice += 1
    end
end

Quando("verifico se todos os campos estão livres") do
    expect(page.has_xpath?("//select[@disabled]")).to eq false
    expect(page.has_xpath?("//input[@disabled]")).to eq false
end

Quando("eu clico em selecione") do
    elementos_acesso.selecioneExportar.click()
end

Quando("clico na opção de seleção") do
    elementos_acesso.exportacaoExcel.click()
end

Entao("se abre uma nova aba") do
  expect(page.driver.browser.window_handles.length.should).to eq 2
end