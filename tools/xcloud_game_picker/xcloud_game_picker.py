from time import sleep
from typing import Any, List
from selenium import webdriver
from selenium.webdriver.common.by import By

from models.xcloud_game import XcloudGame
import json

driver = webdriver.Edge()
driver.get("https://www.xbox.com/en-US/play/gallery/all-games")
games_grid = driver.find_element(by=By.CLASS_NAME, value="GameItemGrid-module__postitionRelative___1SLzN")
done: bool = False

def getGamesInGrid(grid) -> Any:
    return grid.find_elements(by=By.TAG_NAME, value="a")
def removeRepeated(list: List[XcloudGame]) -> List[XcloudGame]:
    for external_index, external_game in enumerate(list):
        for internal_index, internal_game in enumerate(list, start=external_index + 1):
            if(internal_game.gameTitle == external_game.gameTitle):
                try:
                    del list[internal_index]
                except:
                    continue

    return list

page_scroll_point = 0
page_height = driver.execute_script("return document.body.scrollHeight")
games_list: List[XcloudGame] = []
while not done:
    c: int = 0
    for game in getGamesInGrid(games_grid):
        game_label: str = game.get_attribute("aria-label")
        game_title = game_label.split(',')[0].strip()
        game_publisher = game_label.split(',')[1].strip()

        game_url = game.get_attribute("href")

        game_image_element = game.find_element(by=By.TAG_NAME, value="img")
        game_image_url = game_image_element.get_attribute("src")

        games_list.append(XcloudGame(game_title, game_publisher, game_url, game_image_url))

    page_scroll_point += 1500
    driver.execute_script(f"window.scrollTo(0, {page_scroll_point})")
    sleep(1)
    done = page_scroll_point >= page_height

driver.close()

games_list = removeRepeated(games_list)
json_str = json.dumps([ob.__dict__ for ob in games_list], indent=4)

with open('xcloud_games_database.json', 'w+') as outfile:
    outfile.write(json_str)