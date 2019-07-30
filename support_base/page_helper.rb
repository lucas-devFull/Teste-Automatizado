Dir[File.join(File.dirname(__FILE__), '..pages/*_page.rb')].each { |file| require file }
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

    def elementos_default
        @elementos_default = Elementos_default.new
    end
end