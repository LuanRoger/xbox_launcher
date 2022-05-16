from dataclasses import replace
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

def formatWidthHeight(url: str) -> str:
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
        game_label: str = game.get_attribute("aria-label")
        game_title = game_label.split(',')[0].strip()
        game_publisher = game_label.split(',')[1].strip()

        game_url = game.get_attribute("href")

        game_image_element = game.find_element(by=By.TAG_NAME, value="img")
        tile_image_url = formatWidthHeight(game_image_element.get_attribute("src"))

        # Get hero image
        driver.execute_script("window.open()")
        driver.switch_to.window(driver.window_handles[1])
        driver.get(game_url)

        hero_image = driver.find_element(by=By.CLASS_NAME, value="HeroBackgroundImage-module__heroImage___2JqG_")
        game_image_url = formatWidthHeight(hero_image.get_attribute("src"))

        driver.execute_script("window.close()")
        driver.switch_to.window(driver.window_handles[0])

        games_list.append(XcloudGame(game_title, game_publisher, game_url, tile_image_url, game_image_url))

    page_scroll_point += 1500
    driver.execute_script(f"window.scrollTo(0, {page_scroll_point})")
    sleep(0.5)
    done = page_scroll_point >= page_height

driver.close()

json_str = json.dumps([ob.__dict__ for ob in games_list], indent=4)

outfile = open('xcloud_games_database.json', 'w+')
outfile.write(json_str)
outfile.close()