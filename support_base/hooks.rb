Before do         
    page.driver.browser.manage.window.resize_to(1600,1000) 
end

After do |scenario|
    if scenario.name.include?('Exemplos')
        scenario_name = scenario.name.gsub(/\ /,'_').gsub(',_Exemplos_(#','_').gsub(')','')
    else
        scenario_name = scenario.name.gsub(/\ /,'_')
    end

    if scenario.failed?
        # metodo tirarFoto esta em helper.rb
        tirarFoto(scenario_name,'falhou','idioma_pt')
    else
        tirarFoto(scenario_name,'passou','idioma_pt')
    end

    wait_for_ajax
    @MenuUsuario = find_by_id('menu-de-usuario')

    if verificaUsuarioFinal() == true
        @MenuUsuario.click()
    else 
        @MenuUsuario.double_click().click()
    end
    find("a[href='#{CONFIG['url_padrao']}/logout/fulltime']").click()
end
