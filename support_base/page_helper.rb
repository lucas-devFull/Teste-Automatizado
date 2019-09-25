Dir[File.join(File.dirname(__FILE__), '..pages/*_page.rb')].each { |file| require file 
    puts file
}
    require_relative 'elementos_default_page.rb'
    #nao esquecer de criar a page com o _page no final
    

module ClassesParaInstanciar
    def cad_empresa 
        @cad_empresa ||= Empresa.new
    end

    def cad_agendamento
        @cad_agendamento ||= Agendamento.new
    end

    def config_fcell
        @config_fcell ||= Fcell.new
    end

    def ponto_referencia
        @ponto_referencia ||= Ponto_referencia.new
    end

    def elementos_ponto_referencia
        @elementos_ponto_referencia ||= Elementos_ponto_referencia.new
    end

    def acesso
        @acesso ||= Acesso.new
    end

    def elementos_acesso
        @elementos_acesso ||= Elementos_acesso.new        
    end

    def elementos_default
        @elementos_default ||= Elementos_default.new
    end

    def elementos_clientes
        @elementos_clientes ||= Elementos_clientes.new
    end

    def clientes
        @clientes ||= Clientes.new
    end
    
end