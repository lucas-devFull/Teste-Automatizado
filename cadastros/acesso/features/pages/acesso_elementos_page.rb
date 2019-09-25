class Elementos_acesso < SitePrism::Page

    set_url "#{CONFIG['url_teste']}"

    def variaveisMap(var)
        variaveis = {
            :fabricante => 'ras_efb_id',
            :operadora => 'ras_ras_operadora',
            :numChip => 'ras_ras_chip',
            :imei => 'ras_ras_imei',
            :linha => 'ras_ras_linha',
            :etiqueta => 'ras_ras_etiqueta',
            :produto => 'ras_ras_prd_id',
            :IdEquipamento => 'ras_ras_id_aparelho',
            :selectFcell => 'config_fcell',
            :selectFlitro => 'filtros-servidor',
            :pesquisa_produto => 'pesquisa_produto',

        # oficina
            :rastreadorOficina => 'rastreador',
            :produtoOficina => 'produto',
            :clienteOficina => 'cliente',
            :veiculoOficina => 'veiculo',

        # Cadastro de veiculos
            :rastreadorCadVeiculo => 'ras_vei_equipamento',
            :tipoCadVeiculo => 'ras_vei_tipo',
            :inputDescricaoCadVei => 'ras_vei_veiculo',
            :inputPlacaCadVei => 'ras_vei_placa',
            :clienteCadVei => 'ras_vei_id_cli',
        }
      
        if var.kind_of?(Array)
            outro = []
            for i in var
                outro << variaveis[:"#{i}"]
            end
            return outro
        else
          return variaveis[:"#{var}"]
        end
    end

# botoes tela principal
    element :btn_acesso, "a[href='http://homologacao.fulltrack2.com/rastreadores/acesso_controller']"
    element :ativarRegistro, "#ativar"
    element :desativarRegistro, "#desativar"

# selects e inputs
    elements :listaFabricante, :xpath, "//select[@id='ras_efb_id']/option"
    elements :listaProdutos, :xpath, "//select[@id='ras_ras_prd_id']/option"
    element :chaveConfiguracao, :xpath, "//span[@id='ip_porta']"
    element :pesquisa_produto, "#pesquisa_produto"
    element :selectProduto, "#ras_ras_prd_id"
    element :selectFabricante, "#ras_efb_id"
    element :option_equ_2630, :xpath, "//input[@id='ras_ras_rede_can']"
    element :inputPesquisa, :xpath, "//input[@aria-controls='cadastro-acesso']"
    
# grid
    element :ordenacao, :xpath, "//table[@id='cadastro-acesso']/thead/tr/th[@class='sorting_asc']"
    element :ordenacaoAtivo, :xpath, "//table[@id='cadastro-acesso']/thead/tr/th[@class='sorting'][1]"
    element :ordenacaoAtivoAsc, :xpath, "//table[@id='cadastro-acesso']/thead/tr/th[@class='sorting_asc']"
    element :ordenacaoAtivoDesc, :xpath, "//table[@id='cadastro-acesso']/thead/tr/th[@class='sorting_desc']"
    element :idEquipamentoGrid, :xpath, "//table[@id='cadastro-acesso']/tbody/tr[1]/td[6]"
    element :idGrid, :xpath, "//table[@id='cadastro-acesso']/tbody/tr[@class='odd'][1]/td[1]"
    element :idEquipamento, :xpath, "//table[@id='cadastro-acesso']/tbody/tr[1]/td[6]"
    element :acessosLivres, :xpath, "//table[@class='table table-bordered table-striped box-filtros']/tbody/tr[1]/td/font"
    element :acessosUtilizados, :xpath, "//table[@class='table table-bordered table-striped box-filtros']/tbody/tr[2]/td/font"
    element :selecioneExportar, :xpath, "//div[@class='btn btn-default dropdown-toggle ft-button-div']"
    element :exportacaoExcel, :xpath, "//div[@id='export-dropdown']/ul[@class='dropdown-menu']/li/a[@class='exportEXCEL']"

# tela Oficina
    element :selectRastreadorOfic, "#rastreador"
    element :selectVeiculo, "#veiculo"
    element :inputOficina, :xpath, "//div[@id='table-oficina_filter']/label/input"
    element :statusOficina, :xpath, "//table[@id='table-oficina']/tbody/tr[@class='odd'][1]/td[8]"
    element :ordenacaoStatus, :xpath, "//table[@id='table-oficina']/thead/tr/th[@class='sorting'][8]"
    element :ordenacaoStatusAsc, :xpath, "//table[@id='table-oficina']/thead/tr/th[@class='sorting_asc']"


# tela cadastro Veiculo
    element :selectRastreadorCadVei, "#ras_vei_equipamento"
    element :inputDescricao, "#ras_vei_veiculo"
    element :inputPlaca, "#ras_vei_placa"
    element :selectTipo, "#ras_vei_tipo"
end