Dado("o login no sistema") do
    elementos_clientes.load()
    loginSistema()
end

Dado("a entrada na pagina") do
    entrarNaPagina('#menu2','10')
end

Quando("clico em adicionar") do
    elementos_default.botao_adicionar.click()
end

Entao("a pagina é redirecionada para o formulario de cadastro") do
    expect(page.has_css?('#ras_cli_razao')).to eq true
end

Entao("clico em cancelar") do
    elementos_default.botao_cancelar.click()
end

Entao("a pagina retorna para a grid") do
    expect(page.has_css?('#clientes')).to eq true
end

Quando("clico em editar") do
    elementos_default.btn_editar.click()
end

Entao("deve aparecer o elemento de alerta") do
    expect(page.has_xpath?("/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']")).to eq true
end

Entao("deve aparecer a mensagem de alerta") do
    @mensagem = find(:xpath, "/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']/p").text()
    verificarMensagens(@mensagem,'alerta')
    elementos_default.btn_confirm.click()
end

Quando("clico em excluir") do
    elementos_default.btn_excluir.click()
end
  
Quando("eu clico na caixa de seleção de exportação") do
    elementos_clientes.caixaSelecao.click()
end

Quando("seleciono o tipo de exportação") do
    elementos_clientes.selecioneExportacao.click()
end

Entao("abrirá uma nova aba") do
  expect(page.driver.browser.window_handles.length.should).to eq 2
end

Entao("o download será vericado e redirecionado até a pagina downloads") do
    verificarDownloads('./Downloads', '.xls','Cadastro de Clientes.xls')
end

Quando("clico em salvar") do
    elementos_default.btn_salvar.click()
end

Entao("o campo Nome Fantasia estará vermelho") do
    expect(page.has_xpath?("//div[@class='form-group has-error']/div[@id='ras_cli_desc']/ul/li")).to eq true
end

Quando("inisiro as inputs obrigatórias {string}") do |string|
    @nomeFantasia = string
    elementos_clientes.nomeFantasiaInput.set(string)
end

Entao("deve aparecer a mensagem de sucesso") do
    @mensagem = find(:xpath, "/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']/p").text()
    verificarMensagens(@mensagem, "sucesso")
    elementos_default.btn_confirm.click()
end

Quando("pesquiso o cliente {string}") do |string|
    @nomeFantasia = string
    @id = clientes.verificaNaGrid(string)
end

Entao("verifico se o registro aparece na grid") do
    expect(elementos_clientes.nomeFantasiaGrid.text).to eq @nomeFantasia    
    expect(elementos_clientes.idGridSelected.text).to eq @id 
end

Quando("clico em enviar convite") do
    elementos_default.btn_enviar_convite.click()
end

Entao("Apago todos os registros referentes a ele") do
    @qtdRegistros = all(:xpath, "//table[@id='clientes']/tbody/tr").length
    clientes.apagar_registros(@qtdRegistros)
end
  
Quando("inisiro os campos de dados pessoais") do
    @campos = elementos_clientes.variaveisMap(['NomeFantasia',
        'razaoSocial',
        'tipo',
        'liberado',
        'cpfCnpj',
        'endereco',
        'bairro',
        'cidade',
        'cep',
        'estado',
        'pais'
    ])

    @valores = ['Teste Automatico',
        'Teste Automatico',
        'J',
        'S',
        '48897587801',
        'Rua Argemiro Soares Correa',
        'Jd Teruel',
        'Alvinlandia',
        '17430-000',
        'São Paulo',
        'Brasil',
    ]
    preencheCampos(@campos,@valores)
end

Quando("verifico nas selects se o cliente aparece lá") do
    clientes.verificaNaSelect(@id,@nomeFantasia)
end

Quando("mudo o selecionado de SIM para NÃO") do
    select_by_value('ras_cli_liberado','N')
end
  
Entao("nao poderei ver os veiculos do cliente escolhido") do
    iniciarApp()
    driver.find_element(:class, "android.widget.EditText").send_keys('Teste Cadastro Clientes')
    sleep(6)
    # expect(@nomeCliente.text).to eq nomeFantasia
end

Quando("entro na tela de relatorios de trajeto percorrido") do
    entrarNaPaginaEspecifica('relatorioTrajetoPercorrido/relatorio_trajeto_percorrido')
end

Quando("seleciono o cliente") do
    select_by_value('idCliente',@id)
end

Quando("seleciono o veiculo") do
    select_by_value('idVeiculo',@id)
end

Quando("clico na parte contatos") do
    elementos_clientes.telaContatos.click()
end

Quando("adiciono a {string}, {string}, {string}, {string}") do |string, string2, string3, string4|
    @descContato = string
    @email = string2
    @celular = string4
    @campos = elementos_clientes.variaveisMap(['descContato','emailContato','DDIcelular','telefonecontato'])
    @valores = [string, string2, string3, string4]
    preencheCampos(@campos,@valores)
    sleep(2)
end

Quando("clico em adicionar contato") do
    elementos_clientes.btn_adicionar_contato.click()
    sleep(5)

end

Quando("adiciono o nome fantasia {string}") do |nomeFantasia|
    find_by_id('ras_cli_desc').set(nomeFantasia)
end

Entao("verifico se o registro nao aparece na grid") do
    select_by_attribute(elementos_clientes.variaveisMap('selectFlitro'),'id', 'ras_cli_desc')
    sleep(2)
    elementos_clientes.inputGrid.set('Test Contatos')
    sleep(2)
    elementos_clientes.ordenacaoId.click()     
    sleep(2)
    expect(page.has_css?('.dataTables_empty')).to eq true
end

Quando("entro na tela de contato") do
    @telas = [
        'cadastros/veiculo_controller',
        'cadastros/contato_controller'
    ]
end

Entao("verifico se as informaçõs batem") do
    indice = 0
    while indice < @telas.length
        entrarNaPaginaEspecifica(@telas[indice])

        if @telas[indice] == 'cadastros/contato_controller'
            find(:xpath, "//div[@id='table-contato_filter']/label/input").set(@id)
            expect(elementos_clientes.tdEmail.text).to eq @email
            expect(elementos_clientes.tdCelular.text).to eq @celular
        else
            cadVeiculo(@id,nomeFantasia,'Teste Cadastro Clientes')
            elementos_default.btn_editar.click()
            elementos_clientes.telaContatos.click()
            expect(page.has_text?(@nomeFantasia)).to eq true
        end
        indice +=1
    end
end

Quando("clico no icone do alerta") do
    elementos_default.btn_alerta.click()    
end

Quando("seleciono o ultimo alerta") do
    find(:xpath, "//table[@id='example-table-os-abertas']/tbody/tr[@class='tr-os-aberta odd'][1]/td[1]").click()
    sleep(2)
    find_by_id("btn-call-box-tratar-evento-unico").click()
    sleep(5)
end

Entao("eu finalizo o chamado e verifico se as informações de contato batem") do
    sleep(2)
    expect(page.has_xpath?("//div[@id='content-dados-rapidos']/div[@id='info-cliente']/div/span[1]").text).to eq @nomeFantasia
    sleep(2)
    find(:xpath, "//ul[@id='header-dados-rapidos']/li[3]/a").click()
    sleep(2)
    expect(page.has_xpath?("//div[@id='info-detalhes-contatos-autorizados']/div/span[3]").text).to eq @celular
end