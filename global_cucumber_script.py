import subprocess
import os

def listaDiretorio():
    for pasta in os.listdir('./'):
        if os.path.isdir(pasta):
                print(pasta)
                p = subprocess.Popen(['cucumber'], cwd=pasta)
                p.wait()
listaDiretorio()        