from typing import Any, Tuple, List
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC

from .models.xcloud_game import *
from .models.game_properties import *
from .xcloud_elements_consts import SUPPORTED_INPUTS_CONTAINER, GAME_INFO_BOX_XPATH, GAME_SUBTITLE_ELEMENT, GAME_TITLE_H1_ELEMENT, GAME_PROPERTIES_CONTAINER, STORE_BUTTON_ELEMENT
from .webdriver_utils import *
from .utils.url_formater import *

def getTileGameImageUrl(gamePicture) -> str:
    img_element = gamePicture.find_element(by=By.TAG_NAME, value="img")
    image_src_set: str = img_element.get_attribute("srcset").split(',')

    image_src = image_src_set[1][:-2].strip()
    return image_src

def getGamesInGrid(grid) -> Any:
    return grid.find_elements(by=By.TAG_NAME, value="a")

def getGamesInfoInNewTab(driver, game_url: str) -> XcloudGame:
    open_new_tab(driver)
    goto_tab(driver, 1)
    driver.get(game_url)

    if("games" not in driver.current_url):
        close_current_tab(driver)
        goto_tab(driver, 0)
        return None

    finder: WebDriverWait = WebDriverWait(driver, 30).until(
            EC.presence_of_element_located((By.CLASS_NAME, GAME_TITLE_H1_ELEMENT))
    )

    game_title = driver.find_element(by=By.CLASS_NAME, value=GAME_TITLE_H1_ELEMENT).text
    game_properties: GameProperties = getGamesProperties(driver.find_element(by=By.CLASS_NAME, value=GAME_PROPERTIES_CONTAINER))
    store_url: str = driver.find_element(by=By.CLASS_NAME, value=STORE_BUTTON_ELEMENT).find_element(by=By.TAG_NAME, value="a").get_attribute("href")
    game_genre = getGameGenres(driver)

    hero_image = driver.find_elements(by=By.TAG_NAME, value="source")
    game_image_url = format_hero_image(hero_image[0].get_attribute("srcset"))

    game_info_box = getInfoFromGameBox(driver)

    close_current_tab(driver)
    goto_tab(driver, 0)

    return XcloudGame(game_title, game_info_box[0], game_info_box[1], game_genre, game_info_box[2],
         game_properties, None, None, game_image_url, store_url)

def getGamesProperties(gameInfoContainer) -> GameProperties:
    is_in_gamepass: bool = False
    try:
        gameInfoContainer.find_element(by=By.TAG_NAME, value="svg")
        is_in_gamepass = True
    except:
        pass

    supported_inputs_container = gameInfoContainer.find_element(by=By.CLASS_NAME, value=SUPPORTED_INPUTS_CONTAINER).find_element(by=By.TAG_NAME, value="div")
    supported_inputs = supported_inputs_container.find_elements(by=By.TAG_NAME, value="svg")

    d = len(supported_inputs)
    support_controller: bool = len(supported_inputs) >= 1
    touch_controller: bool = len(supported_inputs) >= 2

    return GameProperties(is_in_gamepass, support_controller, touch_controller)

def getGameGenres(driver) -> List[str]:
    separator = '•'

    subtitle = driver.find_element(by=By.CLASS_NAME, value=GAME_SUBTITLE_ELEMENT).text
    formated_subtitle = subtitle.split(separator)
    return [genre.strip() for genre in formated_subtitle[1:]]

def getInfoFromGameBox(driver) -> Tuple[str]:
    game_infos = driver.find_elements(by=By.XPATH, value=GAME_INFO_BOX_XPATH)

    return (game_infos[0].text, game_infos[1].text, game_infos[2].text)