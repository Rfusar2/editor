from myImap import EMAIL
import os

#Connect
credenziali = {
    "dominio": "",
    "email": "",
    "password": "",
}
with EMAIL(credenziali) as casella:
    casella.ShowFolders()



#Parse
with open("", "rb") as f: file = f.read()
EMAIL.Parse(MSG=file, save={"path": ".\\", name=os.path.basename(file).split(".")[0] exts=["all"]})
