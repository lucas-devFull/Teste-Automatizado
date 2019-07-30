class Empresa < SitePrism::Page
    include Capybara::DSL
    include RSpec::Matchers

    set_url "#{CONFIG['url_login']}"

    element :descricao, "#ras_mon_desc"
    element :razaoSocial, "#ras_mon_razao"
    element :email, "#ras_mon_email"
    element :endereco, "#ras_mon_endereco"
    element :bairro, "#ras_mon_bairro"
    element :pais, "#ras_mon_pais"
    element :estado, "#ras_mon_estado"
    element :cidade, "#ras_mon_cidade"

    element :mensagem, :xpath, "//div[@class='sweet-alert showSweetAlert visible']/p/span"
    element :msgAlertaExclusaoComregistro, :xpath, "//div[@class='sweet-alert showSweetAlert visible']/p/fieldset/legend[@class='fix-errors'][1]/span"
    element :pesquisa, :xpath, "//div[@id='table-empresas_filter']/label/input" 
    element :ordenacao, :xpath, "//div[@id='table-empresas_wrapper']/table[@id='table-empresas']/thead/tr/th[@class='sorting_asc']"
    element :razaoSocialGrid, :xpath, "//table[@id='table-empresas']/tbody/tr[@class='tr odd'][1]/td[3]"
    element :idGrid, :xpath, "//table[@id='table-empresas']/tbody/tr[@class='tr odd'][1]/td[1]"
    element :menuUsuario, "#menu-de-usuario"
    element :trocarEmpresa, "#trocar-empresa"
    element :escolherEmpresa, "#empresa_chosen"
    element :pesquisaEmpresa, :xpath, "//div[@id='empresa_chosen']/div[@class='chosen-drop']/div[@class='chosen-search']/input"

    element :selecioneExportacao, :xpath, "//div[@id='export-dropdown']/div[@class='btn btn-default dropdown-toggle ft-button-div']"
    element :exportarExcel, '.exportEXCEL'

    def preencherCampos(arrayCampos)
        descricao.set(arrayCampos[0])
        razaoSocial.set(arrayCampos[1])
        email.set(arrayCampos[2])
        endereco.set(arrayCampos[3])
        bairro.set(arrayCampos[4])
        pais.set(arrayCampos[5])
        estado.set(arrayCampos[6])
        cidade.set(arrayCampos[7])
    end

    def pegarId(stringPesquisa)
        wait_for_ajax
        pesquisa.set(stringPesquisa)
        wait_for_ajax
        ordenacao.click()
        @idGrid = idGrid.text
        return @idGrid 

    end

    def verificarNaGrid(stringPesquisa)
        wait_for_ajax
        pesquisa.set(stringPesquisa)
        # ordenacao.click()
        wait_for_ajax
    end

    def verificarAcessoMonitoramento(stringPesquisa)
        wait_for_ajax
        if acessoOutrasEmpresas() == true 
            wait_for_ajax
            trocarEmpresa.click()
            wait_for_ajax
            sleep(2)
            escolherEmpresa.click()
            pesquisaEmpresa.set(stringPesquisa)
            wait_for_ajax
        else
            puts "ele é de master sem mais camadas para baixo"
        end
    end

    def selecionarRegistro(pesquisa)
        busca_grid.set(pesquisa)
        wait_for_ajax
        ordenacao.click()
        wait_for_ajax
        @id = campoId.text
        campoId.click()

        return @id
    end
end

