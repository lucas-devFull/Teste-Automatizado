class VerificaString
    include Capybara::DSL
    include RSpec::Matchers
    require_relative 'traducao.rb'

    def verificar(idiomaAtual,fraseVerificacao,filtro)
        @traducao = Traducao.new
        if idiomaAtual == 'Português (Brasil)' || idiomaAtual == ' Portuguese (Brazil) ' || idiomaAtual == ' Portuguese (Brazil) '
            return @traducao.traducaoString(1,fraseVerificacao,filtro)
        elsif idiomaAtual == 'Inglês' || idiomaAtual == 'English' || idiomaAtual == ' Ingles  '
            return @traducao.traducaoString(2,fraseVerificacao,filtro)
        else
            return @traducao.traducaoString(3,fraseVerificacao,filtro)
        end
    end
end