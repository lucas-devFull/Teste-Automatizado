import subprocess
file = '../../support_base/helper.rb'

subprocess.call(['cucumber'])

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

replanceStrings(file, portugues, ingles)

subprocess.call(['cucumber'])

replanceStrings(file, ingles, espanhol)

subprocess.call(['cucumber'])

replanceStrings(file, espanhol, portugues)
