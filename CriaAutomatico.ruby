def pastasIniciantes(opcaoMenu,pasta)
    system("cd #{opcaoMenu} ; mkdir #{pasta} ; cd #{pasta} ; cucumber --init ;  mkdir results; mkdir Downloads ; mkdir reports ; ")
    system("cd support_base ; cp cucumber.yml ../#{opcaoMenu}/#{pasta} ;  cp idiomas_script.rb ../#{opcaoMenu}/#{pasta} ; ")
    system("cd #{opcaoMenu}/#{pasta}/features ;  mkdir pages ; mkdir specs ;" )
    system("cd #{opcaoMenu}/#{pasta}/features/step_definitions ; touch #{pasta}.rb ;" )
    system("cd #{opcaoMenu}/#{pasta}/features/pages ; touch #{pasta}_elementos_page.rb")
    system("cd #{opcaoMenu}/#{pasta}/features/pages ; touch #{pasta}_page.rb")
    system("cd #{opcaoMenu}/#{pasta}/features/specs ; touch #{pasta}.feature")
    editandoArquivos(opcaoMenu,pasta)
 end
 
 def editandoArquivos(opMenu, pasta)
    env = File.open("#{opMenu}/#{pasta}/features/support/env.rb",'w')
    env.write('require_relative "../../../../support_base/env.rb"')  
 
    pageElementos = File.open("#{opMenu}/#{pasta}/features/pages/#{pasta}_elementos_page.rb", 'w')
    pageElementos.write(" class Elementos_#{pasta} < SitePrism::Page
 
       set_url '# {CONFIG['url_7112']}'    
 
    def variaveisMap(var)
       variaveis = {
       }
 
       if var.kind_of?(Array)
          outro = []
          for i in var
                outro << variaveis[:'# {i}']
          end
          return outro
       else
          return variaveis[:'# {var}']
       end
 
    end
 end"
 )
 
    pageFuncoes = File.open("#{opMenu}/#{pasta}/features/pages/#{pasta}_page.rb", 'w')
    pageFuncoes.write("class #{pasta.capitalize} < Elementos_#{pasta}
       include Capybara::DSL
       include RSpec::Matchers
       
    end")
 
    specs = File.open("#{opMenu}/#{pasta}/features/specs/#{pasta}.feature", 'w')
    specs.write("# language: pt")

   end
 
 
 puts 'Selecione uma opção do menu'
 
 @opcaoMenu = gets.chomp()
 
 puts 'Selecione uma tela'
 
 @pasta = gets.chomp()
 
 @pasta = @pasta.downcase().gsub(' ',"_")
 
 @opcaoMenu = @opcaoMenu.downcase().gsub(' ',"_")
 
 
 if File.exist?(@opcaoMenu)
    if File.exist?("#{@opcaoMenu}/#{@pasta}")
       puts "ja tem essa pasta"
       system("exit ;")
    else
       pastasIniciantes(@opcaoMenu,@pasta) 
    end
 else
    system("mkdir #{@opcaoMenu} ; ")
    pastasIniciantes(@opcaoMenu,@pasta)
 end
 
 puts("olhar novamente a tela de #{@tela}_elementos_page, é necessario  colocar em ordem as variaveis com '# {alguacoisa}' e o set_url") 
 
 
 puts("implantar (se necessario em Page Helper)") 