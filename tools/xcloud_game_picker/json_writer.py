from genericpath import exists
import json
from typing import List
from consts import GAMES_JSON_FILE_PATH

def flush_game_list(list: List):
    json_str = json.dumps([dict(ob) for ob in list], indent=4)

    outfile = open(GAMES_JSON_FILE_PATH, 'a') if exists(GAMES_JSON_FILE_PATH) else open(GAMES_JSON_FILE_PATH, 'w+')
    outfile.write(json_str)
    outfile.close()

    list.clear()