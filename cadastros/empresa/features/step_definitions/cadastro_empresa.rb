# cad_empresa é uma instancia da classe Empresa em empresa_page.rb, ela esta instanciada globalmente em support_base/page_helper.rb
# os metodos sem o 'cad_empresa' no começo são globais e estao localizados em support_base/helper.rb

Dado("login no sistema") do
    cad_empresa.load
    loginSistema()
end

# teste botao novo
Entao("devo ser redirecionado ao formulario de cadastro de empresa") do
    expect(page.has_css?('div#form-cadastro')).to eq true
end

Quando("clico em cancelar") do
    find_by_id('btn-cancelar').click()
end

Entao("deve ser exibida mensagem de confirmação de cancelamento") do
    verificarMensagens(cad_empresa.mensagem.text,'alerta')
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

# Cadastro normal
Dado("entrada no cadastro de empresa") do
    entrarNaPagina('#menu2','19')
end

Quando("clico em adicionar") do
    find_by_id('btn-adicionar-item').click()
end

Quando("Adiciono os campos {string},{string},{string},{string},{string},{string},{string},{string}") do |descricao, razaoSocial, email, endereco,bairro, pais, estado,cidade|
    @campos = [descricao, razaoSocial, email, endereco,bairro,pais, estado,cidade]
    cad_empresa.preencherCampos(@campos)
    @razaoSocial = razaoSocial
end

Quando("eu clico em salvar") do
    find_by_id('btn-salvar').click()
end

Entao("deve ser exibido o elemento de alerta") do
    wait_for_ajax
    expect(page).to have_xpath("/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")
end

Entao("deve ser exibida mensagem de sucesso") do
    @mensagem = find(:xpath, "//div[@class='sweet-alert showSweetAlert visible']/h2").text
    verificarMensagens(@mensagem,'sucesso')
    find(".confirm").click()
end

Entao("verifico na grid se ele foi cadastrado") do
    wait_for_ajax
    @idUltimocadastro = cad_empresa.pegarId(@razaoSocial)
    cad_empresa.verificarNaGrid(@idUltimocadastro)
    expect(page.assert_text(@idUltimocadastro)).to eq true
end

Entao("verifico se ela aparece no acesso do monitoramento") do
    cad_empresa.verificarAcessoMonitoramento(@idUltimocadastro)
    expect(page).to have_text(@idUltimocadastro)    
end

# teste botao excluir
Entao("deve ser exibida mensagem de alerta") do
    verificarMensagens(cad_empresa.mensagem.text,'alerta')
    find('.confirm').click()
end

# teste de exclusao com empresa que ainda possui cadastros no sistema
Entao("deve ser exibida mensagem de alerta com registro") do
    verificarMensagens(cad_empresa.msgAlertaExclusaoComregistro.text,'alerta')
    find('.confirm').click()
end

# excluir cadastro
Quando("seleciono um registro {string}") do |string|
    @empresaExcluida = string
    @ultimoId = cad_empresa.pegarId(@empresaExcluida)
    find(:xpath , "//div[@id='table-empresas_wrapper']/table[@id='table-empresas']/tbody/tr[@class='tr odd'][1]/td[1]").click()
end

Quando("clicar em excluir") do
    find_by_id('btn-excluir-item').click()
end

Quando("deve ser exibida mensagem de deletado com sucesso") do
    @mensagem = find(:xpath, "//div[@class='sweet-alert showSweetAlert visible']/p").text
    verificarMensagens(@mensagem,'sucesso')
    find('.confirm').click()
end

Entao("verifico na grid se ele foi apagado") do
    cad_empresa.verificarNaGrid(@ultimoId)
    expect(page.has_css?('.dataTables_empty')).to eq true
end

Entao("verifico se ela ainda aparece no acesso do monitoramento") do
    reload_page()
    cad_empresa.verificarAcessoMonitoramento(@ultimoId)
    wait_for_ajax
    expect(page.has_css?('.no-results')).to eq true

end

# edição
Quando("clico em editar") do
    find_by_id("btn-editar-item").click()    
end

Quando("altero os campos para {string},{string},{string},{string},{string},{string},{string},{string}") do |descricao, razaoSocial, email, endereco, bairro, pais, estado, cidade|
    @campos = [descricao, razaoSocial, email, endereco,bairro,pais,estado,cidade]
    cad_empresa.preencherCampos(@campos)
    @razaoSocial = razaoSocial
end

Entao("deve ser exibida mensagem de alterado com sucesso") do
    @mensagem = find(:xpath, "//div[@class='sweet-alert showSweetAlert visible']/p").text
    verificarMensagens(@mensagem,'sucesso')
    find('.confirm').click()
end

Entao("verifico na grid se ele foi alterado") do
    cad_empresa.verificarNaGrid(@ultimoId)
    expect(page.assert_text(@razaoSocial)).to eq true
end

Entao("verifico se a alteração aparece no acesso do monitoramento") do
     reload_page()
     cad_empresa.verificarAcessoMonitoramento(@ultimoId)
     wait_for_ajax
     expect(page).to have_text(@ultimoId)
end

# exportação da grid
Quando("eu clico em Selecione") do
    cad_empresa.selecioneExportacao.click()
end

Quando("clico em microsoft excel") do
    cad_empresa.exportarExcel.click()
end

Entao("uma nova aba irá abrir e baixar a exportação") do
    page.driver.browser.window_handles.length.should == 2
end