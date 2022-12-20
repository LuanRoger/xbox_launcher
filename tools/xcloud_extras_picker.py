from typing import List
from selenium import webdriver
from selenium.webdriver.common.by import By
from internals.models.xcloud_game import XcloudGame

from xcloud_extras.consts import *
from internals.shared_consts import XCLOUD_BASE_URL
from internals.element_picker import getGamesInGrid, getGamesInfoInNewTab, getTileGameImageUrl
from internals.webdriver_utils import *
from internals.xcloud_elements_consts import *
from internals.json_writer import *
from internals.utils.url_formater import *

driver = webdriver.Edge()
driver.get(XCLOUD_RECENTLY_ADDED_URL)
games_grid = driver.find_element(by=By.CLASS_NAME, value=GAMES_GRID_ELEMENT)
games = getGamesInGrid(games_grid)

games_list: List[XcloudGame] = []
for game in games:
    game_url: str = game.get_attribute("href")
    game_image_src: str = getTileGameImageUrl(game.find_element(by=By.TAG_NAME, value="picture"))
    tile_image_url = add_parameter_sprinter(game_image_src)

    xcloud_game = getGamesInfoInNewTab(driver, game_url)
    xcloud_game.xcloudUrl = add_formater_game_url_server(game_url, XCLOUD_BASE_URL)
    xcloud_game.tileGameImageUrl = tile_image_url

    games_list.append(xcloud_game)

driver.close()
flush_game_list(games_list, RECENTLY_ADDED_JSON_FILE)