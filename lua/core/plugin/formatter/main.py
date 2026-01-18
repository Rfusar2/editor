import sys
import json
import os
import xml.dom.minidom

input_file = sys.argv[2]  # file temporaneo con contenuto
output_file = sys.argv[1] # file originale

# Legge contenuto
with open(input_file, "r", encoding="utf-8") as f:
    content = f.read()

# Determina tipo da estensione
if output_file.endswith(".json"):
    try:
        data = json.loads(content)
        formatted = json.dumps(data, indent=4, ensure_ascii=False)
    except Exception as e:
        print("Errore JSON:", e)
        formatted = content
elif output_file.endswith(".xml"):
    try: 
        dom = xml.dom.minidom.parseString(content) 
        pretty_xml = dom.toprettyxml(indent=" ") 
        formatted = "\n".join([line for line in pretty_xml.splitlines() if line.strip()]) 
    except Exception as e:
        print("Errore XML:", e)
        formatted = content
else:
    formatted = content

with open(output_file, "w", encoding="utf-8", errors="replace") as f:
    f.write(formatted)


os.remove(input_file)
