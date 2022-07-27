from time import sleep
from typing import Any, List
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from models.xcloud_game import XcloudGame
from consts import XCLOUD_URL
from json_writer import *

driver = webdriver.Edge()
driver.get(XCLOUD_URL)
games_grid = driver.find_element(by=By.CLASS_NAME, value="GameItemGrid-module__postitionRelative___1SLzN")
done: bool = False

def getGamesInGrid(grid) -> Any:
    return grid.find_elements(by=By.TAG_NAME, value="a")

def add_formater_game_url_server(url: str) -> str:
    base_url = "https://www.xbox.com/"
    return base_url + "%s/" + url[len(base_url):]

def add_formater_width_height(url: str) -> str:
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

page_scroll_point = 0
page_height = driver.execute_script("return document.body.scrollHeight")
games_list: List[XcloudGame] = []
while not done:
    for game in getGamesInGrid(games_grid):
        game_url = game.get_attribute("href")

        game_image_element = game.find_element(by=By.TAG_NAME, value="img")
        tile_image_url = add_formater_width_height(game_image_element.get_attribute("src"))

        driver.execute_script("window.open()")
        driver.switch_to.window(driver.window_handles[1])
        driver.get(game_url)

        finder = WebDriverWait(driver, 30).until(
            EC.presence_of_element_located((By.CLASS_NAME, "GameItemContainer-module__titleText___3qvVD"))
        )

        game_title = driver.find_element(by=By.CLASS_NAME, value="GameItemContainer-module__titleText___3qvVD").text
        game_publisher = driver.find_element(by=By.CLASS_NAME, value="GameItemContainer-module__subtitleText___2c69Z").text

        hero_image = driver.find_element(by=By.CLASS_NAME, value="HeroBackgroundImage-module__heroImage___2JqG_")
        game_image_url = add_formater_width_height(hero_image.get_attribute("src"))

        driver.execute_script("window.close()")
        driver.switch_to.window(driver.window_handles[0])

        new_game = XcloudGame(game_title, game_publisher, add_formater_game_url_server(game_url), tile_image_url, game_image_url)

        if(new_game not in games_list):
            games_list.append(new_game)

    page_scroll_point += 1600
    driver.execute_script(f"window.scrollTo(0, {page_scroll_point})")
    done = page_scroll_point >= page_height
    sleep(0.5)

driver.close()
flush_game_list(games_list)