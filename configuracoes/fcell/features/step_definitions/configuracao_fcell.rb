# config_fcell é uma instancia da classe Fcell em fcell_page.rb, ela esta instanciada globalmente em support_base/page_helper.rb
# os metodos sem o 'config_fcell' no começo são globais e estao localizados em support_base/helper.rb

Dado("login no sistema") do
    config_fcell.load
    loginSistema()
end

Dado("entrada na página de configuração do Fcell") do
    entrarNaPagina('#menu6','4')
end

# testes Botao - Novo
Então("devo ir ao formulário de Configuração FCell") do
    wait_for_ajax
    expect(page.has_css?('section#form-cadastro')).to eq true
end

# cadastro
Quando("eu clico no botão de novo") do
    find_by_id('btn-adicionar-item').click()
end

Quando("incluo {string}, {int}, {string} e seleciono a opção {int}") do |descricao,enviosBuffer,intervaloComunicacao,habilitar|
    config_fcell.preencherCampos(descricao,enviosBuffer,intervaloComunicacao,habilitar)    
    @descricaoCadastro = descricao
end

Quando("clico no botão Salvar") do
    find_by_id('btn-salvar').click()
end

Então("deve ser exibido o elemento de alerta") do
    wait_for_ajax
  expect(page).to have_xpath("/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")
end

Então("deve ser exibida mensagem de sucesso") do
    verificarMensagens(config_fcell.mensagem.text,'sucesso')
    find(".confirm").click()
end

Então("deve buscar o registro cadastrado na grid") do
    config_fcell.verificarNaGrid(@descricaoCadastro)
    wait_for_ajax
    expect(config_fcell.gridDescricao.text).to eq @descricaoCadastro
    @id = config_fcell.gridId.click()
    @idCadastro = @id.text
    foto('verificacao de cadastro na Grid','passou')
end
  
Então("verificar se ele aparece no cadastro de acesso ao selecionar a opcao de busca Fcell") do
    wait_for_ajax
    config_fcell.verificarNoCadAcesso()
    select_by_value('config_fcell',@idCadastro)
    expect(config_fcell.selectConfigFcell.has_xpath?("//select[@id='config_fcell']/option[@value='#{@idCadastro}']")).to eq true

end

# testes Botao - Excluir
Então("ser exibido uma mensagem para escolher um registro") do
    verificarMensagens(config_fcell.mensagem.text,'alerta')
    foto("alerta para selecionar um registro",'passou')
    find('.confirm').click()
end

# exclusao
Quando("eu busco e seleciono o registro na grid") do
    @descConfigFcell = "Guilherme"
    config_fcell.verificarNaGrid(@descConfigFcell)
    wait_for_ajax
    @idGrid = config_fcell.gridId.click()
    @id = @idGrid.text
end

Quando("clico no botão Excluir") do
    find_by_id('btn-excluir-item').click()
end

Então("deve ser exibida mensagem de confirmação de exclusão") do
    verificarMensagens(config_fcell.mensagem.text,'alerta')
end

Então("devo clicar no botão Sim") do
    find('.sa-confirm-button-container').click()
end

Entao("verifico se o registro ja saiu da grid") do
    wait_for_ajax
    config_fcell.verificarNaGrid(@id)
    expect(page.has_css?('.dataTables_empty')).to eq true
    foto('verificacao de exclusao na Grid','passou')
end

Então("verifico se ele desapareceu do cadastro de acesso ao selecionar a opcao de busca Fcell") do
    config_fcell.verificarNoCadAcesso()
    expect(config_fcell.selectConfigFcell.has_xpath?("//select[@id='config_fcell']/option[@value='#{@id}']")).to eq false
end

#edicao 
Quando("clico no botão Editar") do
    find_by_id('btn-editar-item').click()
end

Então("edito {string}, {string},{string},{int}") do |descricaoEdicao, enviosBuffer, intervaloComunicacao, habilitar|
    config_fcell.preencherCampos(descricaoEdicao,enviosBuffer,intervaloComunicacao,habilitar)
    @descricaoEdicao = descricaoEdicao
end

Então("deve buscar o registro alterado na grid") do
    wait_for_ajax
    config_fcell.verificarNaGrid(@id)
    expect(config_fcell.gridDescricao.text).to eq @descricaoEdicao
    foto('alteracao dos campos','passou')
end

Então("verificar se ele tambem foi alterado na opcao de busca Fcell") do
    config_fcell.verificarNoCadAcesso()
    select_by_value('config_fcell',@id)
    expect(find(:xpath, "//select[@id='config_fcell']/option[@value='#{@id}']").text).to eq @descricaoEdicao
end