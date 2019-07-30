import subprocess
helper = '../../support_base/helper.rb'
relatorio = 'cucumber.yml'

portugues = 'pt-BR'
ingles = 'en-US'
espanhol = 'es-ES'

def replanceStrings(filename, old_string, new_string):
    with open(filename) as f:
        s = f.read()
        if old_string not in s:
            print '"{old_string}" not found in {filename}.'.format(**locals())
            return False
 
    with open(filename, 'w') as f:
        print 'Changing "{old_string}" to "{new_string}" in {filename}'.format(**locals())
        s = s.replace(old_string, new_string)
        f.write(s)
        return True

replanceStrings(relatorio,'relatorio_configuracao_fcell','relatorio_configuracao_fcell_portugues')
subprocess.call(['cucumber','--t', '@exclusao_fcell'])

replanceStrings(relatorio,'relatorio_configuracao_fcell_portugues','relatorio_configuracao_fcell_ingles')
replanceStrings(helper, portugues, ingles)

subprocess.call(['cucumber','--t', '@exclusao_fcell'])

replanceStrings(relatorio,'relatorio_configuracao_fcell_ingles','relatorio_configuracao_fcell_espanhol')
replanceStrings(helper, ingles, espanhol)

subprocess.call(['cucumber','--t', '@exclusao_fcell'])

replanceStrings(helper, espanhol, portugues)
