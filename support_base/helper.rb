include RSpec::Matchers
require_relative 'verificaString.rb'
# metodos globais 

# metodo para tirar um print da tela da onde ele foi chamado, Obs: ele aparece no relatorio
def tirarFoto(nome_arquivo,resultado,linguaguem)
    caminho_arquivo = "results/screenshots/relatorio_#{linguaguem}/test_#{resultado}"
    foto = "#{caminho_arquivo}/#{nome_arquivo}.png"
    page.save_screenshot(foto)
    embed(foto, 'image/png', 'Clique Aqui')
end  

# Nao mexer... carrega os ambientes(producao,homologacao e teste), mudar o ambiente em cucumber.yml na page em que deseja trocar
def carregandoYML(ambiente)
    return YAML.load_file(File.dirname(__FILE__) + "/ambiente/#{ambiente}.yml")
end

# metodo global para logar no sistema
def loginSistema
    # login com cadastros prontos
    # find('input#login').set('anabiaaaa') # indice cliente
    # find('input#password').set('pass')
    find('input#login').set('admin') # indice admin
    find('input#password').set('uQXWy6ec')

    # indice novo, inicio de cadastro 22/07/2019
    # find('input#login').set('Consa') # indice admin
    # find('input#password').set('123456')
    # find('input#login').set('LucasConsa') # indice cliente
    # find('input#password').set('123456')

    find('.btn').click()              

    find('#menu-de-linguagens').click()
    @idioma = find("a[href='#{CONFIG['url_padrao']}/configuracao_sistema_controller/altera_idioma_link/pt-BR']")
    trocaIdioma(@idioma)
    sleep 2
end

# metodo global para entrar na pagina, verificar pelo Xpath ou inspector de elemento o id do menu que tu quer acessar ex: cadastro, seu id é '#menu2',
# e o numCadastro seria o numero da li em que o cadastro esta, Ex: NumCadastro == 10, acessa o cadastro de cliente
def entrarNaPagina(menu,numCadastro)
    wait_for_ajax
    find_by_id("menu").click()
    find("a[href='#{menu}']").click()
    wait_for_ajax
    find(:xpath,"//ul[@id='#{menu.gsub('#','')}']/li[#{numCadastro}]/a[@class='item-menu']").click()
end

# pega o idioma atual em que o sistema esta
def idiomaAtual
    @idiomaAtual = find('#menu-de-linguagens')
    return @idiomaAtual.text            
end

# metodo para esperar uma requisição ajax terminar
def wait_for_ajax
        Timeout.timeout(Capybara.default_max_wait_time) do
        loop do
        active = page.evaluate_script('jQuery.active')
        break if active == 0
        sleep 3
        end
    end
end

# metodo para recarregar uma pagina
def reload_page
    page.evaluate_script("window.location.reload()")
end

# verifica a mensagem do alerta, Ex: quando voce cadastra algo no sistema, ele ira te retornar um alerta de sucesso, esse metodo irá verificar se aquela mensagem esta correta
# olhe dentro da classe TRADUCAO, se a frase estiver correta, coloque - a dentro do array em que pertence
# se um tipo de alerta nao estiver aqui, adicione dentro do if
def verificarMensagens(mensagemRetorno,tipoMensagem)
    @verificaString = VerificaString.new
    if tipoMensagem == 'sucesso'
        sleep(1)
        expect(@verificaString.verificar(idiomaAtual(),mensagemRetorno,'sucesso')).to eq  mensagemRetorno   
    elsif tipoMensagem ==  'erro'
        sleep(1)            
        expect(@verificaString.verificar(idiomaAtual(),mensagemRetorno,'erro')).to eq  mensagemRetorno
    elsif tipoMensagem ==  'alerta'
        sleep(1)            
        expect(@verificaString.verificar(idiomaAtual(),mensagemRetorno,'alerta')).to eq  mensagemRetorno

    end
end

# #metodo para ver se sou usuario (max,e master com terceira camanda camadas) ou usuario (master sem terceira camada, admin e usuario final)
def acessoOutrasEmpresas
    find_by_id("menu-de-usuario").double_click().click()
    @acesso = page.has_css?("li#trocar-empresa")
    if @acesso == true
        return true
    else
        find("#menu-de-usuario").double_click()
        return false 
    end
end

def foto(string)
    # passar o cenario ja como String, NAO ESQUECER
        tirarFoto(string.gsub(/\ /,'_'),'passou','idioma_pt')
end

def select_by_value(id, value)
    find(:xpath, "//select[@id='#{id}']/option[@value='#{value}']").click()
end

def trocaIdioma(idioma)
    if verificaUsuarioFinal() == true
        idioma.double_click()
    else 
        idioma.double_click().click()
    end    
end

def verificarCamposObrigatorios(campos,msg_erro)
    for i in campos do
        expect(find("#{i}").has_css?("#{msg_erro}"))
    end
end

def verificaUsuarioFinal()
    if evaluate_script("$('#usuario_final').val()") == '1'
        return true
    else
        return false
    end
end

# os passos sao passos[0] -> input de pesquisa, passos[1] -> registro com Id inicial (Ex: automatizaçõesÇensácionais ou lúca$$~Consa), passos[2] -> grid(tabela), passos[3] -> css que indica que nao há registros na tabela,
# passos[4] -> localização da ordenação, passos[5] -> botão de excluir, passos[6] -> botão "SIM" de confirmação da exclusão
def ApagaTodosRegistros(passos)
    passos[0].set(passos[1])
    while passos[2].has_no_css?(passos[3]) do
        passos[4].click()
        passos[5].click()
        passos[6].click()
    end
end

def consultasNoMapa(url,pesquisa,tipo,cliente,informacao)
    visit "#{CONFIG['url_padrao']}/#{url}"
    wait_for_ajax
    sleep 5
    if page.has_css?('#iframe_map')
        within_frame('iframe_map') do 
            wait_for_ajax
            evaluate_script('$(".leaflet-bar-part")[1].click()')
            consultasMap(tipo,informacao,cliente)
        end
    else
        botaoPesquisa(pesquisa)
        consultasMap(tipo,informacao,cliente)
    end
end

def consultasMap(tipo,informacao,cliente)
    select_by_value('lista-tipos',tipo)
    case tipo
    when 1
        find_by_id("busca-endereco").set(informacao)
    when 2
        select_by_value("mapa-lista-cliente",cliente)
        wait_for_ajax
        select_by_value("ponto-ref-lista",informacao)
    when 3
        select_by_value("mapa-lista-cliente",cliente)
        select_by_value("cerca-lista",informacao)
    when 4 
        select_by_value("mapa-lista-cliente",cliente)
        select_by_value("iti-lista",informacao)
    when 5
        find_by_id("busca-placa").set(informacao)
    when 6
        puts "vai aparecer a tabela"
    end

    expect(find('#ponto-ref-lista').value).to eq @id
end

def botaoPesquisa(numeroBotao)
    find(:xpath, "//div[@class='leaflet-control-container']/div[@class='leaflet-top leaflet-left']/div[@class='leaflet-bar leaflet-control'][#{numeroBotao}]/a[@class='leaflet-bar-part']").click()
end