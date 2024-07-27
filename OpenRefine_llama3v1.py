# Co jsem udělal? V OpenRefine spustil jazykový model Llama 3.1
# Proč? Proč ne? 
# Jak to funguje?
# Do ollama jsem stáhnul llama3.1, díky tomu že to má REST API, tak jsem v to mohl zavolat z OpenRefine. Ten sice umí jen Python 2.7, ale stačilo to. 
# Je to na nějaké velké klíčovky? Asi ne, pokud nemá nějaké super dělo, ale beru to jako udělátko pro SEO komunitu na ozkoušení.

# Co potřebujete?
# 1) Nainstalovat https://ollama.com/
# 2) Stáhnout model https://ollama.com/library/llama3.1 >> v konsoli windows "ollama run llama3.1"
# 3) Naintalovat a spustit Open refine. https://openrefine.org/
# 4) Připravit si tabulku se sloupečkem co má být promt. (ve skriptu jako value)
# 5) Přidat sloupeček z předchozího sloupečku. Edit Column > add column based on this column
# 6) Přepnout se na Python
# 7) Vložit skript a spustit
# 8) Dlouho čekat :D 

import urllib2
import json

url = "http://localhost:11434/api/generate"
data = {
        "model": "llama3.1:latest",
        "stream": False,
        "prompt": value
}
data_encoded = json.dumps(data).encode('utf-8')
req = urllib2.Request(url, data=data_encoded)
req.add_header('Accept', 'application/json; charset=utf-8')  
response = urllib2.urlopen(req)
response_data = response.read()
json_object = json.loads(response_data.decode('utf-8'))
return json_object["response"]
