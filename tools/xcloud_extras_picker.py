from time import sleep
from typing import List
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from xcloud_extras.consts import XCLOUD_RECENTLY_ADDED_URL
from internals.element_picker import getGamesInGrid
from internals.webdriver_utils import *
from internals.xcloud_elements_consts import *
from internals.json_writer import *
from utils.url_formater import *

driver = webdriver.Edge()
driver.get(XCLOUD_RECENTLY_ADDED_URL)
games_grid = driver.find_element(by=By.CLASS_NAME, value=GAMES_GRID_ELEMENT)
games = getGamesInGrid(games_grid)

for game in games:
    game_url:str = game.get_attribute("href")
    game_image_element = game.find_element(by=By.TAG_NAME, value="img")
    tile_image_url = add_parameter_sprinter(game_image_element.get_attribute("src"))