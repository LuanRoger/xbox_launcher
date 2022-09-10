from typing import Any, Tuple, List
from selenium.webdriver.common.by import By

from models.game_properties import GameProperties
from xcloud_elements_consts import SUPPORTED_INPUTS_CONTAINER, GAME_INFO_BOX_XPATH, GAME_SUBTITLE_ELEMENT

def getGamesInGrid(grid) -> Any:
    return grid.find_elements(by=By.TAG_NAME, value="a")

def getGamesProperties(gameInfoContainer) -> GameProperties:
    is_in_gamepass: bool = False
    try:
        gameInfoContainer.find_element(by=By.TAG_NAME, value="svg")
        is_in_gamepass = True
    except:
        pass

    supported_controller_container = gameInfoContainer.find_element(by=By.CLASS_NAME, value=SUPPORTED_INPUTS_CONTAINER)
    supported_controller_divs = supported_controller_container.find_elements(by=By.TAG_NAME, value="div")

    support_controller: bool = len(supported_controller_divs) >= 1
    touch_controller: bool = len(supported_controller_divs) >= 2

    return GameProperties(is_in_gamepass, support_controller, touch_controller)

def getGameGenres(driver) -> List[str]:
    separator = '•'

    subtitle = driver.find_element(by=By.CLASS_NAME, value=GAME_SUBTITLE_ELEMENT).text
    formated_subtitle = subtitle.split(separator)
    return [genre.strip() for genre in formated_subtitle[1:]]

def getInfoFromGameBox(driver) -> Tuple[str]:
    game_infos = driver.find_elements(by=By.XPATH, value=GAME_INFO_BOX_XPATH)

    return (game_infos[0].text, game_infos[1].text, game_infos[2].text)