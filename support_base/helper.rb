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

def loginFtTools()

    find_by_id('usuario').set('lucas.conceicao')
    find_by_id('senha').set('lucas2k19@!')
    find('.btn-entrar').click()
end

# metodo global para logar no sistema
def loginSistema
    # login com cadastros prontos
    # find('input#login').set('anabiaaaa') # indice cliente
    # find('input#password').set('pass')
    # find_by_id('login').set('admin') # indice admin
    # find_by_id('password').set('uQXWy6ec')

    # teste hardware login
    find_by_id('login').set('lucasc')
    find_by_id('password').set('lucasc')

    #  indice 7112
    find_by_id('login').set('lucas')
    find_by_id('password').set('admin')

    # indice novo, inicio de cadastro 22/07/2019
    # find('input#login').set('Consa') # indice admin
    # find('input#password').set('123456')
    # find('input#login').set('LucasConsa') # indice cliente
    # find('input#password').set('123456')

    find('.btn-login').click()              

    # find('#menu-de-linguagens').click()
    # @idioma = find("a[href='#{CONFIG['url_padrao']}/configuracao_sistema_controller/altera_idioma_link/pt-BR']")
    # trocaIdioma(@idioma)
    sleep 2
end

# metodo global para entrar na pagina, verificar pelo Xpath ou inspector de elemento o id do menu que tu quer acessar ex: cadastro, seu id é '#menu2',
# e o numCadastro seria o numero da li em que o cadastro esta, Ex: NumCadastro == 10, acessa o cadastro de cliente
def entrarNaPagina(menu,numCadastro)
    find(".ft-menu-toggle").click()
    find("a[href='#{menu}']").click()
    sleep(4)
    find(:xpath,"//ul[@id='#{menu.gsub('#','')}']/li[#{numCadastro}]/a[@class='item-menu']").click()
end

def entrarNaPaginaEspecifica(page)
    visit "#{CONFIG['url_padrao']}/#{page}"
    sleep(5)
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

def foto(string,caminho)
    # passar o cenario ja como String, NAO ESQUECER
        tirarFoto(string.gsub(/\ /,'_'),caminho,'idioma_pt')
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
        expect(find_by_id("#{i}").has_css?("#{msg_erro}"))
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

def consultasNoMapa(url,pesquisa,tipo,cliente,informacao,acao)
    visit "#{CONFIG['url_padrao']}/#{url}"
    if page.has_css?('#iframe_map')
        within_frame('iframe_map') do 
            sleep 3
            evaluate_script('$(".leaflet-bar-part")[1].click()')
            consultasMap(tipo,informacao,cliente,acao)
        end
    else
        botaoPesquisa(pesquisa)
        consultasMap(tipo,informacao,cliente,acao)
    end
end

def consultasMap(tipo,informacao,cliente,acao)
    select_by_value('lista-tipos',tipo)
    case tipo
    when 1
        find_by_id("busca-endereco").set(informacao)
    when 2
        select_by_value("mapa-lista-cliente",cliente)
        sleep 2
        if acao == "cadastro" 
            select_by_value("ponto-ref-lista",informacao)
        end
    when 3
        select_by_value("mapa-lista-cliente",cliente)
        if acao == "cadastro"
            select_by_value("cerca-lista",informacao)
        end
    when 4 
        select_by_value("mapa-lista-cliente",cliente)
        if acao == "cadastro"
            select_by_value("iti-lista",informacao)
        end
    when 5
        find_by_id("busca-placa").set(informacao)
    when 6
        puts "vai aparecer a tabela"
    end
end

def botaoPesquisa(numeroBotao)
    find(:xpath, "//div[@class='leaflet-control-container']/div[@class='leaflet-top leaflet-left']/div[@class='leaflet-bar leaflet-control'][#{numeroBotao}]/a[@class='leaflet-bar-part']").click()
end

def select_by_attribute(idSelect,atributo,valueAttr)
    find(:xpath, "//select[@id='#{idSelect}']/option[@#{atributo} ='#{valueAttr}']").click()    
end

def preencheCampos(campos, valores)
    indice = 0
    while indice < campos.length
        if find_by_id(campos[indice]).value != ""
            sleep(1)
            select_by_value(campos[indice],valores[indice])
        else
            find_by_id(campos[indice]).set(valores[indice])
        end
        indice += 1
    end
end

def select?(id)
    puts id
    if evaluate_script("document.getElementById('#{id}').tagName") == 'SELECT'        
        return true
    else
        return false
    end
end

def verificarDownloads(destino, extensao, nomeArquivo)
    indice = 0
    nomeSemEspaços = nomeArquivo.gsub(' ','_')
    while indice < 10
        if File.exist?("/home/lucas/Downloads/#{nomeArquivo}")  && File.extname(nomeArquivo) == extensao
            File.rename "/home/lucas/Downloads/#{nomeArquivo}", "/home/lucas/Downloads/#{nomeSemEspaços}"
            FileUtils.mv("/home/lucas/Downloads/#{nomeSemEspaços}", destino)
            break
        else
            sleep(1)
        end
        indice += 1
    end    
end

def iniciarApp()
    $driver.start_driver
    sleep(8)
    $driver.find_element(:xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup[1]/android.view.ViewGroup/android.view.ViewGroup[1]/android.view.ViewGroup/android.view.ViewGroup[2]
        ").click()

    sleep(5)
end 

def encerrarApp()
    $driver.driver_quit
end