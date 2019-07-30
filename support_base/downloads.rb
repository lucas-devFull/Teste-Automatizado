# o modulo abaixo saiu de um artigo https://collectiveidea.com/blog/archives/2012/01/27/testing-file-downloads-with-capybara-and-chromedriver 
# melhorar muito o codigo em relação ao projeto (codigo não se adequa e algumas funções nao funcionam)

module DownloadHelpers
    TIMEOUT = 10
    PATH    = 'downloads'
  
    extend self
  
    def downloads
      Dir[PATH]
    end
  
    def download
      downloads.first
    end
  
    def download_content(nome_arquivo)
      wait_for_download
      File.read("downloads/#{nome_arquivo}.xls")
    end
  
    def wait_for_download
      Timeout.timeout(TIMEOUT) do
        sleep 2 until downloaded?
      end
    end
  
    def downloaded?
      !downloading? && downloads.any?
    end
  
    def downloading?
      downloads.grep(/\.crdownload$/).any?
    end
  
    def clear_downloads
      FileUtils.rm_f(downloads)
    end
  end
  
  Before do
    clear_downloads()
  end
  
  After do
    clear_downloads()
  end