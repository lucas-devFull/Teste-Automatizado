helper = '../../support_base/helper.rb'
hooks = '../../support_base/hooks.rb'
relatorio = 'cucumber.yml'

portugues = 'pt-BR'
ingles = 'en-US'
espanhol = 'es-ES'

def replanceStrings(filename, old_string, new_string)
    File.open(filename, "r+") { |f|
      s = File.readlines(filename)
      pageAlterada = ''
      s.each do |i|
        i = i.gsub(old_string, new_string)
        pageAlterada << i
      end
     f.write(pageAlterada)
    }
end

system('cucumber')

replanceStrings(relatorio,'relatorio_pt','relatorio_us')
replanceStrings(helper, portugues, ingles)
replanceStrings(hooks,'idioma_pt','idioma_us')
replanceStrings(helper,'idioma_pt','idioma_us')

system('cucumber')

replanceStrings(relatorio,'relatorio_us','relatorio_es')
replanceStrings(helper, ingles, espanhol)
replanceStrings(hooks,'idioma_us','idioma_es')
replanceStrings(helper,'idioma_us','idioma_es')

system('cucumber')

replanceStrings(relatorio,'relatorio_es', 'relatorio_pt')
replanceStrings(helper, espanhol, portugues) 
replanceStrings(hooks,'idioma_es','idioma_pt')
replanceStrings(helper,'idioma_es','idioma_pt')