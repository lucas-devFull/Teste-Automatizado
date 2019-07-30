class Elementos_default < SitePrism::Page
    
    element :botao_cancelar, "#btn-cancelar"
    element :botao_salvar, "#btn_salvar"
    
    # mensagens no sistema (antigo)
    element :mensagem, :xpath, "//div[@class='sweet-alert showSweetAlert visible']/p/span"
    element :elemento_alerta, "/html/body[@class=' stop-scrolling']/div[@class='sweet-alert showSweetAlert visible']"
    element :btn_confirm, '.confirm'

    # mensagens no sistema com izitoast
    element :mensagemIzitoast, :xpath, "//div[@id='JTNDc3BhbiUyMGNsYXNzJTNEJTIyZGF0YS1sYW5ndWFnZSUyMHRlbXBsYXRlX2xpbmVfanMlMjIlMjBkYXRhLWtleS1sYW5ndWFnZSUzRCUyMmNvbXBsZXRlZCUyMiUyMGRhdGEtb3JpZ2luYWwtdGl0bGUlM0QlMjIlMjIlMjB0aXRsZSUzRCUyMiUyMiUzRUNvbmNsdSVDMyVBRGRvJTNDJTJGc3BhbiUzRWdyZWVu']/div[@class='iziToast-body']/div[@class='iziToast-texts']/p[@class='iziToast-message slideIn']/span"
    element :alertaIziToast, :xpath, "//div[@id='JTNDc3BhbiUyMGNsYXNzJTNEJTIyZGF0YS1sYW5ndWFnZSUyMHRlbXBsYXRlX2xpbmVfanMlMjIlMjBkYXRhLWtleS1sYW5ndWFnZSUzRCUyMmRvX3lvdV9yZWFsbHlfd2FudF90b19jYW5jZWxfdGhlX29wZXJhdGlvbiUyMiUyMGRhdGEtb3JpZ2luYWwtdGl0bGUlM0QlMjIlMjIlMjB0aXRsZSUzRCUyMiUyMiUzRURlc2VqYSUyMHJlYWxtZW50ZSUyMGNhbmNlbGFyJTIwYSUyMG9wZXJhJUMzJUE3JUMzJUEzbyUyMCUzRiUzQyUyRnNwYW4lM0VvcmFuZ2U']"
    element :simIzitoast, :xpath, "//div[@class='iziToast-body']/div[@class='iziToast-buttons']/button[@class='iziToast-buttons-child revealIn'][1]"
    element :naoIzitoast, :xpath, "//div[@class='iziToast-body']/div[@class='iziToast-buttons']/button[@class='iziToast-buttons-child revealIn'][2]"


end