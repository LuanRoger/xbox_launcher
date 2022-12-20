from time import sleep
from typing import List
from selenium import webdriver
from selenium.webdriver.common.by import By
from xcloud_game.consts import GAMES_JSON_FILE_PATH

from internals.utils.url_formater import *
from xcloud_game.consts import *
from internals.shared_consts import XCLOUD_BASE_URL
from internals.element_picker import getGamesInfoInNewTab, getGamesInGrid, getTileGameImageUrl
from internals.webdriver_utils import *
from internals.xcloud_elements_consts import *
from internals.models.xcloud_game import XcloudGame
from internals.json_writer import *

driver = webdriver.Edge()
driver.get(XCLOUD_URL)
games_grid = driver.find_element(by=By.CLASS_NAME, value=GAMES_GRID_ELEMENT)
done: bool = False

page_scroll_point = 0
page_height = driver.execute_script("return document.body.scrollHeight")
games_list: List[XcloudGame] = []
while not done:
    for game in getGamesInGrid(games_grid):
        game_url: str = game.get_attribute("href")
        if(add_formater_game_url_server(game_url, XCLOUD_BASE_URL) in [geted_game.xcloudUrl for geted_game in games_list]):
            continue
        
        game_image_src: str = getTileGameImageUrl(game.find_element(by=By.TAG_NAME, value="picture"))
        tile_image_url = add_parameter_sprinter(game_image_src)

        xcloud_game = getGamesInfoInNewTab(driver, game_url)
        if(xcloud_game == None):
            continue
        xcloud_game.xcloudUrl = add_formater_game_url_server(game_url, XCLOUD_BASE_URL)
        xcloud_game.tileGameImageUrl = tile_image_url

        if(xcloud_game not in games_list):
            games_list.append(xcloud_game)

    page_scroll_point += 1700
    driver.execute_script(f"window.scrollTo(0, {page_scroll_point})")
    done = page_scroll_point >= page_height
    sleep(0.5)

driver.close()
flush_game_list(games_list, GAMES_JSON_FILE_PATH)