def open_new_tab(driver):
    driver.execute_script("window.open()")
def close_current_tab(driver):
    driver.execute_script("window.close()")

def goto_tab(driver, tab_index: int):
        driver.switch_to.window(driver.window_handles[tab_index])