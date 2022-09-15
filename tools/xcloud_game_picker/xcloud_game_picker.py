from time import sleep
from typing import List
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from consts import *
from element_picker import getGamesInGrid
from element_picker import getGamesProperties
from models.game_properties import GameProperties
from element_picker import *
from webdriver_utils import *
from xcloud_elements_consts import *
from models.xcloud_game import XcloudGame
from json_writer import *

driver = webdriver.Edge()
driver.get(XCLOUD_URL)
games_grid = driver.find_element(by=By.CLASS_NAME, value=GAMES_GRID_ELEMENT)
done: bool = False

def add_formater_game_url_server(url: str) -> str:
    base_url = XCLOUD_BASE_URL
    return base_url + "%s/" + url[len(base_url):]

def add_parameter_sprinter(url: str) -> str:
    if(url is None): return None

    argument_start = url.find('?')
    arguments = url[argument_start:]

    width_start = arguments.find("w=") + 2
    height_start = arguments.find("h=") + 2
    widht = arguments[width_start : width_start + 3]
    height = arguments[height_start : height_start + 3]
    
    arguments = arguments.replace(widht, "%i", 1)
    arguments = arguments.replace(height, "%i", 1)

    return url[:argument_start] + arguments
def format_hero_image(url: str) -> str:
    if(url is None): return None

    url = url.split(',')[1].strip()
    url = url.split(' ')[0].strip()

    argument_start = url.find('?')
    arguments = url[argument_start:]

    height_start = arguments.find("h=") + 2
    height = arguments[height_start : height_start + 4]
    
    arguments = arguments.replace(height, "%i", 1)

    return "https:" +  url[:argument_start] + arguments

page_scroll_point = 0
page_height = driver.execute_script("return document.body.scrollHeight")
games_list: List[XcloudGame] = []
while not done:
    for game in getGamesInGrid(games_grid):
        game_url: str = game.get_attribute("href")
        if(add_formater_game_url_server(game_url) in [geted_game.xcloudUrl for geted_game in games_list]):
            continue
        
        game_image_element = game.find_element(by=By.TAG_NAME, value="img")
        tile_image_url = add_parameter_sprinter(game_image_element.get_attribute("src"))

        open_new_tab(driver)
        goto_tab(driver, 1)
        driver.get(game_url)

        if("games" not in driver.current_url):
            close_current_tab(driver)
            goto_tab(driver, 0)
            continue
        finder: WebDriverWait = WebDriverWait(driver, 30).until(
            EC.presence_of_element_located((By.CLASS_NAME, GAME_TITLE_H1_ELEMENT))
        )

        game_title = driver.find_element(by=By.CLASS_NAME, value=GAME_TITLE_H1_ELEMENT).text
        game_properties: GameProperties = getGamesProperties(driver.find_element(by=By.CLASS_NAME, value=GAME_PROPERTIES_CONTAINER))

        game_genre = getGameGenres(driver)

        hero_image = driver.find_elements(by=By.TAG_NAME, value="source")
        game_image_url = format_hero_image(hero_image[0].get_attribute("srcset"))

        game_info_box = getInfoFromGameBox(driver)

        close_current_tab(driver)
        goto_tab(driver, 0)

        new_game = XcloudGame(game_title, game_info_box[0], game_info_box[1], game_genre, game_info_box[2],
         game_properties, add_formater_game_url_server(game_url), tile_image_url, game_image_url)

        if(new_game not in games_list):
            games_list.append(new_game)

    page_scroll_point += 1700
    driver.execute_script(f"window.scrollTo(0, {page_scroll_point})")
    done = page_scroll_point >= page_height
    sleep(0.5)

driver.close()
flush_game_list(games_list)