# cad_agendamento é uma instancia da classe Agendamento na agendamento_page.rb, ela esta instanciada globalmente em support_base/page_helper.rb
# os metodos sem o 'cad_agendamento' no começo são globais e estao localizados em support_base/helper.rb

Dado("a realizacao do login e a entrada na pagina de agendamento") do
  cad_agendamento.load
  loginSistema()
  entrarNaPagina("#menu2","10")
end

# teste botao novo
Entao("devo ser redirecionado ao formulario de cadastro de agendamento") do
  expect(page.has_css?('div#form-cadastro')).to eq true
end

Quando("clico em cancelar") do
  find_by_id('btn-cancelar').click()
end

Entao("deve ser exibida mensagem de confirmação de cancelamento") do
  verificarMensagens(cad_agendamento.mensagem.text,'alerta')
end

Entao("devo clicar no botão {string}") do |string|
  if string == 'sim'
      find('.confirm').click()        
  elsif string == 'nao'
      find('.cancel').click()
  end 
end

Entao("a tela voltará a grid") do
  wait_for_ajax
  expect(page.have_css?('.dataTables_wrapper'))
end

Entao("ele ficará no formulario") do
  wait_for_ajax
  expect(page.have_css?('#form-cadastro'))
end

# verificar obrigatoriedade de campos (todos os campos sao obrigatorios)
Entao("deve ser exibido pequenos alertas de erros em baixo de cada input") do
      expect(page.has_css?('.has-error'))
end

# cadastro
Quando("eu clico no botão de novo") do
  find_by_id("btn-adicionar-item").click()
end

Quando("incluo {string}, {string}, {string}, [{string}]") do |cliente, veiculo,periodo,contato|
  @contatos = [contato] 
  @nomeRegistro = cad_agendamento.preencherCampos(cliente,veiculo,periodo,@contatos)
end

Quando("clico no botão Salvar") do
  find_by_id("btn-salvar").click()
end

Então("deve ser exibido o elemento de alerta") do
  wait_for_ajax
  expect(page).to have_xpath("/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")
end

Entao("deve ser exibida mensagem de sucesso") do
  @mensagem = find(:xpath, "//div[@class='sweet-alert showSweetAlert visible']/p/span").text
  verificarMensagens(@mensagem,'sucesso')
  find('.confirm').click()
end

Então("deve buscar o registro cadastrado na grid") do
  wait_for_ajax
  cad_agendamento.verificaNaGrid(@nomeRegistro)
  expect(page).to have_text(@nomeRegistro)
end


# exclusao 
Quando("eu busco e seleciono o registro na grid") do
  @idRegistro = cad_agendamento.selecionarRegistro("ANAA")
end

Então("clicar no botão Excluir") do
  find_by_id("btn-excluir-item").click()
end

Entao("o registro nao estará na grid") do
  wait_for_ajax
  cad_agendamento.verificaNaGrid(@idRegistro)
  expect(page.assert_no_text(@idRegistro)).to eq true
end

#edicao
Então("clico no botão Editar") do
  find_by_id("btn-editar-item").click()
end

Então("edito {string}, {string}, {string},{string},{string}") do |cliente, veiculo, periodo, string4, string5|
  @contatos = [string4,string5]
  @registroEditado = cad_agendamento.preencherCampos(cliente,veiculo,periodo,@contatos)
end

Então("deve buscar o registro editado na grid") do
  wait_for_ajax
  cad_agendamento.verificaNaGrid(@idRegistro)
  expect(page).to have_text(@registroEditado)
end

# exportação da grid
Quando("eu clico em Selecione") do
  cad_agendamento.selecioneExportacao.click()
end

Quando("clico em microsoft excel") do
  cad_agendamento.exportarExcel.click()
end

Entao("uma nova aba irá abrir e baixar a exportação") do
  page.driver.browser.window_handles.length.should == 2
  verificarDownloads('./Downloads','.xls','Cadastro de Agendamento.xls')
end
