import itertools
import random

def generate_random_exp_os(os_list, run_number):
    # All possible combinations
    runs = list(itertools.product(os_list))

    # Shuffle the list to randomize order
    random.shuffle(runs)

    # Writing result

    f = open(f"experiments{run_number}.txt", "w")
    for run in runs:
        f.write(f"{run} \n")
    f.close()

def main():
    scenes = ['Windows Native', 'Linux Native', 'Linux Virtual', 'Linux WSL', 'Windows Virtual']
    accelerators = ['bvh', 'kdtree']
    integrators = ['path', 'volpath']
    for i in range(5):
        generate_random_exp_os(scenes, i)
if __name__ == "__main__":
    main()