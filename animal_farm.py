import animal
import farm

def make_animal(kind):
    """Create an animal class."""
    if kind == 'cat':
        return cat.Cat()
    if kind == 'dog':
        return dog.Dog()
    if kind == 'sheep':
        return sheep.Sheep()
    return animal.Animal(kind)

def main(animals):
    animal_farm = farm.Farm()
    for animal_kind in animals:
        animal_farm.add_animal(make_animal(animal_kind))
    animal_farm.print_contents()
    animal_farm.act('a farmer')

if __name__ == 'main':
    if len(sys.argv) == 1:
        print('Pass at least one animal type!')
        
