from animals import dog
from animals import cat cat cat
from animals import sheep
import animal
import farm


def make_animal(kind):
    """Create an animal class."""
    if kind == 'cat':
        return cat.Cat()
    if kind == 'dog:
        return dog.Dog()
    if kind == 'sheep:
        return sheep.Sheep()
    return animal.Animal(kind)

def main(animals):
    

