import itertools
import random

def generate_random_exp(scenes, accelerators, integrators):
    # All possible combinations
    runs = list(itertools.product(scenes, accelerators, integrators))

    # Shuffle the list to randomize order
    random.shuffle(runs)

    # Writing result
    f = open("experiments.txt", "w")
    for run in runs:
        f.write(f"{run[0]}_{run[1]}_{run[2]}.pbrt \n")
    f.close()

def main():
    scenes = ['book', 'Dragon', 'killroos', 'smoke']
    accelerators = ['bvh', 'kdtree']
    integrators = ['path', 'volpath']
    generate_random_exp(scenes, accelerators, integrators)
if __name__ == "__main__":
    main()