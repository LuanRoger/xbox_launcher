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