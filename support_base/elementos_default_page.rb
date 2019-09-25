class Elementos_default < SitePrism::Page
    
    element :botao_adicionar, "#btn-adicionar-item"
    element :botao_cancelar, "#btn-cancelar"
    element :btn_excluir, "#btn-excluir-item"
    element :btn_salvar, "#btn-salvar"
    element :btn_editar, "#btn-editar-item" 
    element :btn_enviar_convite, "#btn-enviar-convite"
    element :btn_alerta, "#menu-de-alertas"


    # ponto referencia
    element :botao_salvar, "#btn_salvar"
    
    # mensagens no sistema (antigo)
    element :mensagem, :xpath, "/html/body[@class='modal-open stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']/p"
    element :elemento_alerta, "/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']"
    element :btn_confirm, '.confirm'
    element :btn_cancel, '.cancel'

    # mensagens no sistema com izitoast
    element :mensagemSucessoIzitoast, ".iziToast-texts"
    element :alertaIziToast, ".iziToast-capsule"
    element :alertaCancelar, :xpath, "/html/body/div[@class='iziToast-wrapper iziToast-wrapper-topCenter']/div[@class='iziToast-capsule']/div[@id='JTNDc3BhbiUyMGNsYXNzJTNEJTIyZGF0YS1sYW5ndWFnZSUyMHRlbXBsYXRlX2xpbmVfanMlMjIlMjBkYXRhLWtleS1sYW5ndWFnZSUzRCUyMmRvX3lvdV9yZWFsbHlfd2FudF90b19jYW5jZWxfdGhlX29wZXJhdGlvbiUyMiUyMGRhdGEtb3JpZ2luYWwtdGl0bGUlM0QlMjIlMjIlMjB0aXRsZSUzRCUyMiUyMiUzRURlc2VqYSUyMHJlYWxtZW50ZSUyMGNhbmNlbGFyJTIwYSUyMG9wZXJhJUMzJUE3JUMzJUEzbyUyMCUzRiUzQyUyRnNwYW4lM0VvcmFuZ2U']"
    element :simIzitoast, :xpath, "//div[@class='iziToast-body']/div[@class='iziToast-buttons']/button[@class='iziToast-buttons-child revealIn'][1]"
    element :naoIzitoast, :xpath, "//div[@class='iziToast-body']/div[@class='iziToast-buttons']/button[@class='iziToast-buttons-child revealIn'][2]"


    # Aplicativo 

    element :inputNumero, :xpath, "//*[@index='4']"
    element :btn_confirma, :xpath, "//*[@index='6']"
    
    element :inputNumVerificado, :class, "android.widget.EditText"
    element :btn_confirmaVerificacao, :xpath, "//*[@index='4']"
end