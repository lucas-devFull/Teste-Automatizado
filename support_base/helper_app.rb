include RSpec::Matchers
require_relative 'verificaString.rb'

def iniciaAppMeuNumero()

end

def iniciaAppNumDefault()

    sleep(8)

    driver.find_element(:xpath, '//*[@index="4"]').send_keys(14996977689)
    sleep(2)
    driver.find_element(:xpath, "//*[@index='6']").click()

    sleep(6)
    # driver.find_element(:class, "android.widget.EditText").send_keys(654321)
    driver.find_element(:xpath, "//*[@index='4']").click()

    sleep(8)

    driver.find_element(:xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.view.ViewGroup/android.support.v4.widget.DrawerLayout/android.view.ViewGroup/android.view.ViewGroup[1]/android.view.ViewGroup[1]").click()
    # sleep(4)
    # @elementos_default = Elementos_default.new

    # @elementos_default.inputNumero.send_keys(14123456789)
    # sleep(2)
    # @elementos_default.btn_confirma.click()
    # sleep(2)
    # @elementos_default.inputNumVerificado.send_keys(654321)
    # sleep(2)
    # @elementos_default.btn_confirmaVerificacao.click()

end

def precisaRecarregar?()
    # refazer
end