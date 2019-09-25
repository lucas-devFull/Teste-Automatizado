
def listaDiretorios()
    Dir.foreach(".") {|x| 
        if File.directory?(x) && x != '..' && x != '.' && x != '.git' && x != 'support_base'
            for i in Dir.entries(x) do
                if i != '..' && i != '.' && i != 'support_base' 
                    system(" cd #{x}/#{i} ; cucumber ;")
                end
            end              
        end
    }
end

listaDiretorios()