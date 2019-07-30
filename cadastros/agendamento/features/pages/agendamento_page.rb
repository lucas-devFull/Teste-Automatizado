class Agendamento < SitePrism::Page
    include Capybara::DSL
    include RSpec::Matchers

    set_url "#{CONFIG['url_login']}"
    element :cliente, "select[id='ras_age_cli_id']"  
    element :veiculo, "select[id='ras_age_id_veiculo']"
    element :periodo, "select[id='ras_age_periodicidade']"
    elements :contatos, 'ul.list-group > li'
    element :selecionarContato, '.move-right'

    element :mensagem, :xpath, "//div[@class='sweet-alert showSweetAlert visible']/p/span"
    element :selecioneExportacao, :xpath, "//div[@id='export-dropdown']/div[@class='btn btn-default dropdown-toggle ft-button-div']"
    element :exportarExcel, '.exportEXCEL'
    element :busca_grid, :xpath, "//div[@id='tabela_agendamento_filter']/label/input"
    element :ordenacao, :xpath, "//div[@id='tabela_agendamento_wrapper']/table[@id='tabela_agendamento']/thead/tr/th[@class='sorting_asc']"
    element :campoVerificacao, :xpath, "//div[@id='tabela_agendamento_wrapper']/table[@id='tabela_agendamento']/tbody/tr[@class='odd'][1]/td[2]"
    
    element :campoId, :xpath, "//div[@id='tabela_agendamento_wrapper']/table[@id='tabela_agendamento']/tbody/tr[@class='odd'][1]/td[1]"
    element :btn_excluir, "#btn-excluir-item"

    def preencherCampos(stringcliente, stringVeiculo,stringPeriodo,arrayContato)
        @cliente = cliente.select(stringcliente)
        wait_for_ajax
        veiculo.select(stringVeiculo)
        periodo.select(stringPeriodo)

        if contatos.size > 1
            for i in contatos do
                if arrayContato.include?(i.text)
                    i.click()                   
                end
            end                
        end 

        selecionarContato.click()
        return @cliente.text
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

    def verificaNaGrid(nomeRegistro)
        busca_grid.set(nomeRegistro)
        ordenacao.click()
        wait_for_ajax
    end
end
