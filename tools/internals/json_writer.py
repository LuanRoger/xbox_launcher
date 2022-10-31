from genericpath import exists
import json
from typing import List

def flush_game_list(list: List, filePath: str):
    json_str = json.dumps([dict(ob) for ob in list], indent=4)

    outfile = open(filePath, 'a') if exists(filePath) else open(filePath, 'w+')
    outfile.write(json_str)
    outfile.close()

    list.clear()