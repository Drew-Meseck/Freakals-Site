import yaml


def yaml_coerce(value):
    # Allows us to pass in dictionary formatted as a string, and convert it to python dictionary
    if isinstance(value, str):
        return yaml.load(f'dummy: {value}', Loader=yaml.SafeLoader)['dummy']
    return value
