Dado("o login no sitema") do
  elementos_ponto_referencia.load
  sleep(2)
  loginSistema()
  sleep 4
end

Quando("entro na pagina") do
  entrarNaPagina('#menu2','18')
  sleep(2)
end

# teste botao novo
Quando("clico no botão de novo") do 
  elementos_ponto_referencia.botao_novo.click()
end

Então("devo ir ao cadastro de Ponto de Referência") do
  expect(page.has_css?('#ras_ref_descricao'))
end

# teste botao cancelar(voltar para grid)
Então("clico no botão cancelar") do
  elementos_default.botao_cancelar.click()
end

Então("deve ser exibido o elemento de alerta cancelar") do
  wait_for_ajax
  expect(page).to have_xpath("/html/body/div[@class='iziToast-wrapper iziToast-wrapper-topCenter']/div[@class='iziToast-capsule']/div[@id='JTNDc3BhbiUyMGNsYXNzJTNEJTIyZGF0YS1sYW5ndWFnZSUyMHRlbXBsYXRlX2xpbmVfanMlMjIlMjBkYXRhLWtleS1sYW5ndWFnZSUzRCUyMmRvX3lvdV9yZWFsbHlfd2FudF90b19jYW5jZWxfdGhlX29wZXJhdGlvbiUyMiUyMGRhdGEtb3JpZ2luYWwtdGl0bGUlM0QlMjIlMjIlMjB0aXRsZSUzRCUyMiUyMiUzRURlc2VqYSUyMHJlYWxtZW50ZSUyMGNhbmNlbGFyJTIwYSUyMG9wZXJhJUMzJUE3JUMzJUEzbyUyMCUzRiUzQyUyRnNwYW4lM0VvcmFuZ2U']")
end

Então("clico em {string}") do |string|
  if string == 'sim'
    sleep(1)
    elementos_default.simIzitoast.click()
  else
    sleep(1)
    elementos_default.naoIzitoast.click()    
  end
end

Então("retorno para a grid") do
  wait_for_ajax  
  expect(page.has_css?('.bootstrap-table'))
end

# teste botao cancelar(ficar no formulario)

Então("ele continua no formulário") do
  wait_for_ajax
  expect(page.has_css?('#ras_ref_descricao'))
end

# teste input mapa 

Quando("clico em Salvar") do
  elementos_ponto_referencia.botao_salvar.click()
end

Entao("a input {string} irá ficar vermelha") do |string|
  @campos = [string]
  verificarCamposObrigatorios(@campos,'.input-erro')
end

# teste inputs 2

Quando("digito um {string} na input do mapa") do |string|
  ponto_referencia.preencherCampoMapa(string)
  sleep(3)
end

Entao("a input dos campos {string}, {string} e {string} ficarão vermelha") do |string, string2, string3|
  wait_for_ajax
  if verificaUsuarioFinal() == false
    @campos = [string,string2,string3]
    verificarCamposObrigatorios(@campos,'.input-erro')
    find_by_id("menu-de-usuario").double_click().click()
  else
    @campos = [string,string2]
    verificarCamposObrigatorios(@campos,'.input-erro')
    find_by_id("menu-de-usuario").double_click().click()
  end
end

# teste input 3 

Quando("preencho {string}, {string} e {string}") do |ras_ref_descricao, ras_ref_tipo, ras_ref_id_cli|
  if verificaUsuarioFinal() == true
    @campos = [ras_ref_descricao,ras_ref_tipo]
  else
    @campos = [ras_ref_descricao,ras_ref_tipo,ras_ref_id_cli]
  end

  ponto_referencia.preencherCampos(@campos)
end

Quando("apago os dados de {string},{string},{string}") do |string, string2, string3|
  @campos = [string, string2, string3]
  sleep 10
  wait_for_ajax
  ponto_referencia.apagaDados(@campos)
end

Entao("os campos {string}, {string} e {string} ficarão vermelha") do |string, string2, string3|
  @campos = [string, string2, string3]
  wait_for_ajax
  verificarCamposObrigatorios(@campos,'.input-erro') 
end
# cadastro normal

Entao("os campos cidade {string} campo {string}, estado {string} campo {string}, pais {string} campo {string} devem ser preenchidos automaticamente") do |cidade, campoC, estado, campoE, pais, campoP|
  @cidade = cidade
  @estado = estado
  @pais = pais
  @valores = [cidade,estado, pais]
  @campos = [campoC,campoE,campoP]
  ponto_referencia.verificaCamposPreenchidos(@campos, @valores)
end

Quando("deve ser selecionado o cliente no campo {string}") do |cliente|
  @cliente = cliente
  if verificaUsuarioFinal() == false
    select_by_value("ras_ref_id_cli",cliente)
  end 
end

Quando("preencho o campo descrição {string}") do |descricao|
  @desc = descricao 
  elementos_ponto_referencia.descricao.set(descricao)
end

Quando("seleciono um tipo de cadastro no campo {string}") do |tipo|
  wait_for_ajax
  @tipo = tipo
  select_by_value('ras_ref_tipo',tipo)
end

Então("clicar no botao {string}") do |icone| 
  wait_for_ajax
  find_by_id(icone).click()
end

Quando("selecionar o icone {string}") do |icone|
  wait_for_ajax
  @icone = icone
  find(".img-icones[data-nome-icon='#{icone}']").click()
end

Então("deve ser exibido o elemento de alerta iziToast") do
  expect(page.has_css?('.iziToast-capsule')).to eq true 
end

Então("deve ser exibida mensagem de sucesso iziToast") do
  @mensagem = elementos_default.mensagemSucessoIzitoast.text
  verificarMensagens(@mensagem,'sucesso')
end

Então("deve buscar o registro cadastrado na grid como {string}") do |acao|
  wait_for_ajax
  @idGrid = ponto_referencia.verificarNaGrid( @desc)
  @id = @idGrid
  wait_for_ajax
  expect(elementos_ponto_referencia.descGrid.text).to eq @desc
end

Então("deve consultar o registro em mapa do Painel de Bordo como {string}") do |acao|
  sleep(3)
  consultasNoMapa('painel_bordo_controller/index/129167','2',2,@cliente,@id,acao)
  ponto_referencia.verificaConsulta('ponto-ref-lista',acao,@id,@desc)
end

Então("deve consultar o registro em mapa Geral como {string}") do |acao|
  sleep(3)
  consultasNoMapa("mapaGeral",'5',2,@cliente,@id,acao)
  ponto_referencia.verificaConsulta('ponto-ref-lista',acao,@id,@desc)
end

Então("deve consultar o registro em mapa do Dashboard como {string}") do |acao|
  sleep(3)
  consultasNoMapa("dashboard_controller",'5',2,@cliente,@id,acao)
  ponto_referencia.verificaConsulta('ponto-ref-lista',acao,@id,@desc)
end

Então("deve consultar o registro em Relatorio de rotas como {string}") do |acao|
  sleep(3)
  consultasNoMapa("adapter_controller?url=relrotas",'1',2,@cliente,@id,acao)
  ponto_referencia.verificaConsulta('ponto-ref-lista',acao,@id,@desc)
end

Então("deve consultar o registro em veiculos próximos como {string}") do |acao|
  sleep(3)
  ponto_referencia.consultaComIframe('adapter_controller?url=logistica/veiculosproximos',"$('#idCliente').val(#{@cliente})",'.select2-search__field', @desc) 
  within_frame('iframe_map') do
    if acao == "cadastro"
      expect(find('.select2-selection__choice').text().gsub('×','')).to eq @desc
    end
  end
end

Então("deve consultar o registro em cadastro de itinerario") do
  sleep(3)
  ponto_referencia.consultaComIframe('adapter_controller?url=logistica/logisticaitinerario',"$('#ras_cli_id_busca').val(#{@cliente})",'#ras_cli_id_ref', @desc)
  within_frame('iframe_map') do
    # expect(find(".descricao-ponto").text()).to eq @desc
  end
end

Então("deve consultar o registro em cadastro de itinerario_novo como {string}") do |acao|
  sleep(3)
  ponto_referencia.consultaPontoInput('cadastros/itinerario/novo','ras_iti_id_cliente','Rafael Francine','ras_itr_id_referencia',@id,acao)
  if acao  == "cadastro"
    expect(find_by_id('ras_itr_id_referencia').value).to eq @id 
  else
    expect(page.has_xpath?("//select[@id='ras_itr_id_referencia']/option[@value='#{@id}' ]")).to eq false
  end
end

Então("deve consultar o registro em relatório dos pontos de referencia") do
  ponto_referencia.consultaPontoInput('relatorios/ponto_referencia_controller','','','descricaoPonto', @desc,acao)
  expect(first(find(:xpath,"//div[@id='DataTables_Table_0_wrapper']/table[@id='DataTables_Table_0']/tbody/tr[@class='odd']/td[2]")).text()).to eq @desc
  expect(first(find(:xpath,"//div[@id='DataTables_Table_0_wrapper']/table[@id='DataTables_Table_0']/tbody/tr[@class='odd']/td[3]")).text()).to eq 'Rafael Francine'
  expect(first(find(:xpath,"//div[@id='DataTables_Table_0_wrapper']/table[@id='DataTables_Table_0']/tbody/tr[@class='odd']/td[5]")).text()).to eq "#{@cidade} / #{estado}"
end

Então("deve consultar o registro em registro de permanência em ponto como {string}") do |acao|
  ponto_referencia.consultaPontoInput('relatorioPermanenciaPonto/relatorioPermanenciaPonto','','','idPontoRefAutoComplete',@desc.slice(0..-3),acao)
  if acao == 'cadastro'
    expect(find_by_id('idPontoRefAutoComplete').value).to eq @desc
  else
    # expect(find_by_id('idPontoRefAutoComplete').value).to eq ''
    expect(page.has_xpath?("/html/body/div[@class='autocomplete-suggestions ']/div[@data-value='#{@id}']")).to eq false
  end
end

# cadastros

Quando("acesso a página {string}") do |url|
  wait_for_ajax
  visit "#{CONFIG['url_padrao']}/#{url}"
end

Quando("clico na opção de seleção no ponto") do
  @btn_ponto = elementos_ponto_referencia.btn_ponto.click()
end

Quando("seleciono uma opção no mapa") do
  sleep(3)
  elementos_ponto_referencia.zoomIn.click()
  sleep(2)
  @opcao_mapa = evaluate_script("$('.leaflet-tile-loaded')[1]")
  # find(:xpath, "/html/body/section[@class='ft-centerbox ft-menu-plus270px']/div[@id='painel_bordo_id']/div[@class='row ft-zero-margin-row set-fix-height-responsive totais']/div[@class='col-md-8 ft-zero-padding-row box-info']/div[@class='ft-topbox-dashboard map-tamanho-painel-bordo']/div[@id='map-canvas']/div[@class='leaflet-map-pane']/div[@class='leaflet-tile-pane']/div[@class='leaflet-layer']/div[@class='leaflet-tile-container leaflet-zoom-animated']/img[@class='leaflet-tile leaflet-tile-loaded'][1]")
  sleep(2)
  @btn_ponto.drag_to @opcao_mapa.click()
end

Entao("abrirá um modal de cadastro") do
  expect(page.has_css?('.modal-content'))
end

Entao("devo inserir os dados, cliente {string}, descrição do ponto {string} e o tipo do ponto {string}") do |string, string2, string3|
  @cliente = "22647"
  @campos = [string2,string3,string,@cliente]
  @desc = ponto_referencia.preencherCampos(@campos)
end

Quando("selecionar o icone - mapa {string}") do |icone|
  @icone = icone
  wait_for_ajax
  sleep 5
  ponto_referencia.selecionarIcone(icone)
end

Entao("clico em Criar") do
  elementos_ponto_referencia.btn_criar.click()
end


Entao("deve ser exibido o elemento de alerta antigo") do
  wait_for_ajax
  expect(page).to have_xpath("/html/body[@class='modal-open stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")
end

Entao("deve ser exibido o elemento de alerta antigo 1") do
  wait_for_ajax
  expect(page).to have_xpath("/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")
end

Entao("deve ser exibida mensagem de sucesso antigo") do
  wait_for_ajax
  @mensagem = find(:xpath, "//div[@class='sweet-alert showSweetAlert visible']/p").text()
  verificarMensagens(@mensagem, "sucesso")
  elementos_default.btn_confirm.click()
end
Entao("deve consultar o registro em Cadastro de Ponto de Referência como {string}") do |acao|
  sleep 3
  visit "#{CONFIG['url_padrao']}/cadastros/ponto_referencia"
  sleep 2
  @idGrid = ponto_referencia.verificarNaGrid(@desc)
  @id = @idGrid
  sleep 2   
  ponto_referencia.verificaConsultaPF(acao,@desc)
end

Quando("clico no icone dentro do mapa") do
  elementos_ponto_referencia.marker_mapa.click()
end

Quando("selecionarei o icone de cadastro de ponto de referencia") do
  elementos_ponto_referencia.opcao_ponto.click()
end

Quando("pesquisar uma identificação de um veiculo") do
  elementos_ponto_referencia.inputPlaca.set("4808DC3")
  elementos_ponto_referencia.btn_placa.click()
  wait_for_ajax
end

Quando("clico nos clusters") do 
  elementos_ponto_referencia.cluster1.click()
  elementos_ponto_referencia.cluster2.click()
  elementos_ponto_referencia.cluster3.click()
end

Quando("seleciono uma opção no mapa do Dashboard") do
  page.driver.browser.action.move_to(page.find('svg.leaflet-zoom-animated').native).perform
  sleep(2)
  elementos_ponto_referencia.pontoDashboard.click()
end

# excluir 

Quando("Seleciono um registro {string}") do |string|
  wait_for_ajax
  @cliente = "22647"
  @desc = string
  @idGrid = ponto_referencia.selecionarRegistro(string)
  @id = @idGrid
end

Quando("clico em excluir") do
  wait_for_ajax
  sleep 3
  elementos_ponto_referencia.btn_excluir.click()
end

Entao("deve ser exibido o elemento de alerta exclusão") do
  wait_for_ajax
  sleep 2
  expect(page).to have_xpath("/html/body/div[@class='iziToast-wrapper iziToast-wrapper-topCenter']/div[@class='iziToast-capsule']/div[@id='JTNDc3BhbiUyMGNsYXNzJTNEJTIyZGF0YS1sYW5ndWFnZSUyMHRlbXBsYXRlX2xpbmVfanMlMjIlMjBkYXRhLWtleS1sYW5ndWFnZSUzRCUyMmF0dGVudGlvbiUyMiUyMGRhdGEtb3JpZ2luYWwtdGl0bGUlM0QlMjIlMjIlMjB0aXRsZSUzRCUyMiUyMiUzRUF0ZW4lQzMlQTclQzMlQTNvJTNDJTJGc3BhbiUzRSUzQ3NwYW4lMjBjbGFzcyUzRCUyMmRhdGEtbGFuZ3VhZ2UlMjB0ZW1wbGF0ZV9saW5lX2pzJTIyJTIwZGF0YS1rZXktbGFuZ3VhZ2UlM0QlMjJhcmVfeW91X3N1cmUlMjIlMjBkYXRhLW9yaWdpbmFsLXRpdGxlJTNEJTIyJTIyJTIwdGl0bGUlM0QlMjIlMjIlM0VWb2MlQzMlQUElMjB0ZW0lMjBDZXJ0ZXphJTNDJTJGc3BhbiUzRSUzRnJlZA']")
end

Entao("clico em sim") do
  sleep 2
  elementos_default.simIzitoast.click()
end

Entao("deve ser exibida mensagem de excluido com sucesso iziToast") do
  wait_for_ajax
  verificarMensagens(elementos_default.mensagemSucessoIzitoast.text,'sucesso')
end

Entao("devo verificar se o cadastro não está mais na grid como {string}") do |acao|
  elementos_ponto_referencia.gridPesquisa.set(@id)
  ponto_referencia.verificaConsultaPF(acao,@desc)
end

Quando("clico no icone do ponto de referencia") do
  if page.has_css?("#iframe_map")
    within_frame('iframe_map') do
      evaluate_script("$('.leaflet-marker-icon').click()")
    end
  else
      find(".leaflet-marker-icon").click()
  end
end

Entao("clico em excluir pela modal") do
  sleep 2
  if page.has_css?("#iframe_map")
    within_frame("iframe_map") do
      evaluate_script('$(".btn-excluir-ponto").click()')
    end
  else
    elementos_ponto_referencia.btn_excluirPonto_modal.click()
  end
end

Entao("o ponto não deverá estar do mapa") do
  wait_for_ajax
  sleep(2)
  if page.has_css?("#iframe_map") 
    within_frame("iframe_map") do 
      expect(page.has_css?('.leaflet-marker-icon')).to eq false
    end
  else
    expect(page.has_css?(".leaflet-marker-icon")).to eq false
  end
end

Entao("o ponto não deverá estar select") do
  sleep 1
  ponto_referencia.verificaConsulta('ponto-ref-lista','exclusao',@id,@desc)
end

Entao("deve consultar o registro em Cadastro de Ponto de Referência modal como {string}") do |acao|
  sleep 3
  visit "#{CONFIG['url_padrao']}/cadastros/ponto_referencia"
  elementos_ponto_referencia.gridPesquisa.set(@id)
  ponto_referencia.verificaConsultaPF(acao,@desc)
end

# edição
Quando("clico em editar") do
  elementos_ponto_referencia.btn_editar.click()
end

Então("seleciono o registro alterado {string}") do |string|
  sleep(1)
  elementos_ponto_referencia.gridPesquisa.set(string)
  sleep(3)
  elementos_ponto_referencia.idGrid.click()
end

Então("as informações dos campos estaram editadas com os campos {string},{string},{string},{string}") do |cliente,descricao,tipo,icone|
  sleep(3)
  p @icone
  @clientes = find_by_id(cliente).value
  @campos = [cliente,descricao,tipo] 
  @valores = [@clientes[0],@desc,@tipo]
  ponto_referencia.verificaCamposPreenchidos(@campos,@valores)
end

Quando("clico no ponto selecionado") do
  elementos_ponto_referencia.ponto_mapa.click()
end

Quand("preencho o campo descrição {string} pela modal do mapa") do |desc|
  @desc = desc
  sleep(2)
  elementos_ponto_referencia.inputDescMapa.set(desc)
end

Entao("seleciono um tipo de cadastro no campo {string} pela modal do mapa") do |string|
  @tipo = string
  select_by_value('tipo-ponto',@tipo)
end

Entao("e altero os campos cidade {string} campo {string}, estado {string} campo {string}, pais {string} campo {string}") do |cidade, campoC, estado, campoE, pais, campoP|
  @campoC = campoC
  @campoE = campoE
  @campoP = campoP
  @cidade = cidade
  @estado = estado
  @pais = pais
  sleep(1)
  find_by_id(campoC).set(cidade)
  sleep(1)
  find_by_id(campoE).set(estado)
  sleep(1)
  find_by_id(campoP).set(pais)

  sleep(5)

end

Entao("seleciono novamente o registro") do
  select_by_value("ponto-ref-lista",@id)
end

Entao("os campos cidade, estado e pais estaram editados") do
  @campos = [@campoC,@campoE,@campoP] 
  @valores = [@cidade,@estado,@pais]
  ponto_referencia.verificaCamposPreenchidos(@campos,@valores)  
end

Quando("clico no icone para adicionar um tipo de ponto de referencia novo") do
  elementos_ponto_referencia.add_ponto.click()
end

Quando("irá abrir um pop-up") do 
  ponto_referencia.verificaPopUp()
end 

Quando("adiciono uma descrição para o tipo {string}") do |string|
  @descTipo = string
  elementos_ponto_referencia.input_tipo_ponto.set(@desc)
end

Então("clico no pop-up em {string}") do |string|
  if string == "salvar"
    elementos_ponto_referencia.btn_salvar_tipo.click()
  elsif string == "cancelar"
    elementos_ponto_referencia.btn_cancelar_tipo.click()
  end
  sleep(2)
end

Entao("devo inserir os dados, cliente {string}, descrição do ponto {string} e o tipo do ponto {string} no mapa") do |string, string2, string3|
  @cliente = string
  @desc = string2
  @descTipo = string3
  select_by_value(elementos_ponto_referencia.variaveisMap('selectCliente'),@cliente)
  sleep(1)
  elementos_ponto_referencia.inputDescMapa.set(string2)
  elementos_ponto_referencia.novo_tipo_telaAssociada.click()
  sleep(2)
  elementos_ponto_referencia.input_novo_tipo_tela_ass.set(string3)
  elementos_ponto_referencia.confirma_novo_tipo_telaAssociada.click()
  sleep(2)
end

Entao("deve consultar o tipo do ponto em cadastro de ponto referencia como {string}") do |acao|
  elementos_ponto_referencia.descGrid.click()
  elementos_ponto_referencia.btn_editar.click()
  sleep(2)
end

Então("deve consultar o tipo do ponto em mapa do Painel de Bordo como {string}") do |acao|
  consultasNoMapa('painel_bordo_controller/index/129167','2',2,@cliente,@id,acao)
end

Então("verifico se o tipo do campo {string} está selecionado como {string}") do |campoTipo,acao|
  ponto_referencia.verificaTipoPonto(campoTipo,@id,@descTipo,acao)
end

Então("deve consultar o tipo do ponto em mapa Geral como {string}") do |acao|
  consultasNoMapa("mapaGeral",'5',2,@cliente,@id,acao)
end

Então("deve consultar o tipo do ponto em mapa do Dashboard como {string}") do |acao|
  consultasNoMapa("dashboard_controller",'5',2,@cliente,@id,acao)
end

Então("deve consultar o tipo do ponto em Relatorio de permanência em ponto como {string}") do |acao|
  visit "#{CONFIG['url_padrao']}/relatorioPermanenciaPonto/relatorioPermanenciaPonto"
  evaluate_script("$('#idCliente').val('22647')")
end

Entao("excluo o tipo de ponto de referencia {string}") do |tela|
  sleep(10)
  if tela == "telaPrincipal"
    elementos_ponto_referencia.deletar_tipo_referencia.click()
  elsif tela == "telaAssociada"
    elementos_ponto_referencia.deletar_tipo_referencia_telaAssociada.click()    
  end
end

Entao("edito o tipo de ponto de referencia para {string}") do |string|
  elementos_ponto_referencia.btn_editar_popup.click()
  elementos_ponto_referencia.input_editar_tipo_referencia.set('')
  sleep(1)
  elementos_ponto_referencia.input_editar_tipo_referencia.set('luCáS')
  elementos_ponto_referencia.btn_salvar_tipo.click()  
end