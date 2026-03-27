import sys
import json
import os
import xml.dom.minidom
import markdown
from enum import Enum

filetemp = sys.argv[2]  # file temporaneo con contenuto
output_file = sys.argv[1] # file originale

class Extensions(Enum):
    JSON = ".json"
    XML = ".xml"
    MD = ".md"
    HTML = ".html"

class Parser():
    @staticmethod
    def from_json(content):
        data = json.loads(content)
        return json.dumps(data, indent=4, ensure_ascii=False)
    
    @staticmethod
    def from_xml(content):
        dom = xml.dom.minidom.parseString(content) 
        pretty_xml = dom.toprettyxml(indent=" ") 
        return "\n".join([line for line in pretty_xml.splitlines() if line.strip()]) 

    @staticmethod
    def from_md(content):
        return markdown.markdown(content)

JSON = Extensions.JSON.value
XML =  Extensions.XML.value
MD =   Extensions.MD.value
HTML = Extensions.HTML.value

# Legge contenuto
with open(filetemp, "r", encoding="utf-8") as f:
    content = f.read()

# Determina tipo da estensione
try:
    if output_file.endswith(JSON):
        formatted = Parser.from_json(content) 

    elif output_file.endswith(XML):
        formatted = Parser.from_xml(content)

    elif output_file.endswith(MD):
        formatted = Parser.from_md(content)
        output_file = output_file.replace(MD, HTML)

    else:
        formatted = content

    with open(output_file, "w", encoding="utf-8", errors="replace") as f:
        f.write(formatted)
    
    os.remove(filetemp)

except Exception as err: print(str(err))

