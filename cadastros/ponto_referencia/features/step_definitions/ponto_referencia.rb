Dado("o login no sitema") do
  ponto_referencia.load
  loginSistema()
  sleep 2
end

Quando("entro na pagina") do
  entrarNaPagina('#menu2','17')
end

# teste botao novo
Quando("clico no botão de novo") do 
  ponto_referencia.botao_novo.click()
end

Então("devo ir ao cadastro de Ponto de Referência") do
  expect(page.has_css?('#ras_ref_descricao'))
end

# teste botao cancelar(voltar para grid)
Então("clico no botão cancelar") do
  elementos_default.botao_cancelar.click()
end

Então("deve ser exibido o elemento de alerta iziToast") do
  expect(page).to have_xpath("//div[@id='JTNDc3BhbiUyMGNsYXNzJTNEJTIyZGF0YS1sYW5ndWFnZSUyMHRlbXBsYXRlX2xpbmVfanMlMjIlMjBkYXRhLWtleS1sYW5ndWFnZSUzRCUyMmRvX3lvdV9yZWFsbHlfd2FudF90b19jYW5jZWxfdGhlX29wZXJhdGlvbiUyMiUyMGRhdGEtb3JpZ2luYWwtdGl0bGUlM0QlMjIlMjIlMjB0aXRsZSUzRCUyMiUyMiUzRURlc2VqYSUyMHJlYWxtZW50ZSUyMGNhbmNlbGFyJTIwYSUyMG9wZXJhJUMzJUE3JUMzJUEzbyUyMCUzRiUzQyUyRnNwYW4lM0VvcmFuZ2U']")
end

Então("clico em {string}") do |string|
  if string == 'sim'
    elementos_default.simIzitoast.click()
  else
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
  ponto_referencia.botao_salvar.click()
end

Entao("a input {string} irá ficar vermelha") do |string|
  @campos = [string]
  verificarCamposObrigatorios(@campos,'.input-erro')
end

# teste inputs 2

Quando("digito um {string} na input do mapa") do |string|
  ponto_referencia.preencherCampoMapa(string)
  sleep(5)
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
  ponto_referencia.descricao.set(descricao)
end

Quando("seleciono um tipo de cadastro no campo {string}") do |tipo|
  wait_for_ajax
  select_by_value('ras_ref_tipo',tipo)
end

Então("clicar no botao {string}") do |icone| 
  wait_for_ajax
  find_by_id(icone).click()
end

Quando("selecionar o icone {string}") do |icone|
  wait_for_ajax
  find(".img-icones[data-nome-icon='#{icone}']")
end

Então("deve ser exibida mensagem de sucesso iziToast") do
  @mensagem = elementos_default.mensagemIzitoast.text
  verificarMensagens(@mensagem,'sucesso')
end

Então("deve buscar o registro cadastrado na grid") do
  wait_for_ajax
  @idGrid = ponto_referencia.verificarNaGrid( @desc)
  @id = @idGrid
  wait_for_ajax
  expect(ponto_referencia.descGrid.text).to eq @desc
end

Então("deve consultar o registro em mapa do Painel de Bordo") do
  consultasNoMapa("painel_bordo_controller/index/190",'2',2,@cliente,@id)
end

Então("deve consultar o registro em mapa Geral") do
  consultasNoMapa("mapaGeral",'5',2,@cliente,@id)
end

Então("deve consultar o registro em mapa do Dashboard") do
  consultasNoMapa("dashboard_controller",'5',2,@cliente,@id)
end

Então("deve consultar o registro em Relatorio de rotas") do
  consultasNoMapa("adapter_controller?url=relrotas",'1',2,@cliente,@id)
end

Então("deve consultar o registro em veiculos próximos") do
  ponto_referencia.consultaComIframe('adapter_controller?url=logistica/veiculosproximos',"$('#idCliente').val(#{@cliente})",'.select2-search__field', @desc) 
  within_frame('iframe_map') do
    expect(find('.select2-selection__choice').text().gsub('×','')).to eq @desc
  end
end

Então("deve consultar o registro em cadastro de itinerario") do
  ponto_referencia.consultaComIframe('adapter_controller?url=logistica/logisticaitinerario',"$('#ras_cli_id_busca').val(#{@cliente})",'#ras_cli_id_ref', @desc)
  within_frame('iframe_map') do
    # expect(find(".descricao-ponto").text()).to eq @desc
  end
end

Então("deve consultar o registro em cadastro de itinerario_novo") do
  ponto_referencia.consultaPontoInput('cadastros/itinerario/novo','ras_iti_id_cliente','ANAA','ras_itr_id_referencia',@id)
  expect(find_by_id("ras_itr_id_referencia").value).to eq @id
end

Então("deve consultar o registro em relatório dos pontos de referencia") do
  ponto_referencia.consultaPontoInput('relatorios/ponto_referencia_controller','','','descricaoPonto', @desc)
  expect(first(find(:xpath,"//div[@id='DataTables_Table_0_wrapper']/table[@id='DataTables_Table_0']/tbody/tr[@class='odd']/td[2]")).text()).to eq @desc
  expect(first(find(:xpath,"//div[@id='DataTables_Table_0_wrapper']/table[@id='DataTables_Table_0']/tbody/tr[@class='odd']/td[3]")).text()).to eq 'ANAA'
  expect(first(find(:xpath,"//div[@id='DataTables_Table_0_wrapper']/table[@id='DataTables_Table_0']/tbody/tr[@class='odd']/td[5]")).text()).to eq "#{@cidade} / #{estado}"
end

Então("deve consultar o registro em registro de permanência em ponto") do
  ponto_referencia.consultaPontoInput('relatorioPermanenciaPonto/relatorioPermanenciaPonto','','','idPontoRefAutoComplete',@desc.slice(0..-3))
  wait_for_ajax
  expect(find_by_id('idPontoRefAutoComplete').value).to eq @desc
end

# cadastro por painel de bordo

Quando("acesso a página {string}") do |url|
  wait_for_ajax
  visit "#{CONFIG['url_padrao']}/#{url}"
end

Quando("clico na opção de seleção no ponto") do
  @btn_ponto = ponto_referencia.btn_ponto
  @btn_ponto.click()
end

Quando("seleciono uma opção no mapa") do
  wait_for_ajax
  @opcao_mapa = evaluate_script("$('.leaflet-tile-loaded')[1]")
  sleep(2)
  @btn_ponto.drag_to @opcao_mapa.click()
end

Entao("abrirá um modal de cadastro") do
  expect(page.has_css?('.modal-content'))
end

Entao("devo inserir os dados, cliente {string}, descrição do ponto {string} e o tipo do ponto {string}") do |string, string2, string3|
  @cliente = "15931"
  @campos = [string2,string3,string,@cliente]
  @desc = ponto_referencia.preencherCampos(@campos)
end

Quando("selecionar o icone - mapa {string}") do |icone|
  wait_for_ajax
  sleep 10
  ponto_referencia.selecionarIcone(icone)
end

Entao("clico em Criar") do
  ponto_referencia.btn_criar.click()
end


Entao("deve ser exibido o elemento de alerta antigo") do
  wait_for_ajax
  expect(page).to have_xpath("/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")

end

Entao("deve ser exibida mensagem de sucesso antigo") do
  wait_for_ajax
  verificarMensagens(elementos_default.mensagem.text, "sucesso")
  elementos_default.btn_confirm.click()
end

Entao("deve consultar o registro em Cadastro de Ponto de Referência") do
  sleep 5
  visit "#{CONFIG['url_padrao']}/cadastros/ponto_referencia"
  wait_for_ajax
  @idGrid = ponto_referencia.verificarNaGrid(@desc)
  @id = @idGrid
  wait_for_ajax
  expect(ponto_referencia.descGrid.text).to eq @desc
end

Quando("clico no icone dentro do mapa") do
  ponto_referencia.marker_mapa.click()
end

Quando("selecionarei o icone de cadastro de ponto de referencia") do
  ponto_referencia.opcao_ponto.click()
end

Quando("pesquisar uma identificação de um veiculo") do
  find_by_id("placa").set("2213132")
  find_by_id("btn_placa").click()
  wait_for_ajax
end

Quando("seleciono uma opção no mapa do Dashboard") do
  @opcao_mapa = evaluate_script('$("svg.leaflet-zoom-animated")')
  page.find(@opcao_mapa).trigger(:mouseenter)
  # @btn_ponto.drag_to @opcao_mapa
end