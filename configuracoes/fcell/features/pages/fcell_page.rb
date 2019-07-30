class Fcell < SitePrism::Page
    include Capybara::DSL
    include RSpec::Matchers

    set_url "#{CONFIG['url_login']}"
    element :descricao, '#fcc_descricao'
    element :enviosBuffer, '#fcc_numero_envios_buffer'
    element :intervalo, "select[id='fcc_intervalo_comunicacao_segundos']"
    element :habilita, '#fcc_opcao_ligar_desligar'

    element :mensagem, :xpath, "//div[@class='sweet-alert showSweetAlert visible']/p/span"
    element :pesquisa, :xpath, "//div[@id='table-configuracao_wrapper']/div[@id='table-configuracao_filter']/label/input"
    element :ordenacao, :xpath, "//div[@id='table-configuracao_wrapper']/table[@id='table-configuracao']/thead/tr/th[@class='sorting_asc']"
    element :gridDescricao, :xpath, "//div[@id='table-configuracao_wrapper']/table[@id='table-configuracao']/tbody/tr[@class='odd'][1]/td[2]"
    element :gridId, :xpath, "//div[@id='table-configuracao_wrapper']/table[@id='table-configuracao']/tbody/tr[@class='odd'][1]/td[@class='sorting_1']"

    element :addAcesso, "#btn-adicionar-item" 
    element :pesquisaProduto, "input#pesquisa_produto"
    element :selectConfigFcell, 'select#config_fcell'

    def preencherCampos(desc,buffer,intervaloComunicacao,habilitar)
        descricao.set(desc)
        enviosBuffer.set(buffer)
        intervalo.select(intervaloComunicacao)
        if habilitar == 1
            habilita.check()
        else
            habilita.uncheck()
        end 
    end

    def verificarNaGrid(stringPesquisa)
        pesquisa.set(stringPesquisa)
        wait_for_ajax
        ordenacao.click()
    end

    def verificarNoCadAcesso()
        visit "#{CONFIG['url_padrao']}/rastreadores/acesso_controller/"
        addAcesso.click()
        pesquisaProduto.set("F/cell")
        pesquisaProduto.send_keys :enter
        selectConfigFcell.click()
    end
end
