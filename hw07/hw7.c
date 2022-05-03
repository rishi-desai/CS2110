/**
 * @file hw7.c
 * @author Rishi Desai
 * @collaborators NAMES OF PEOPLE THAT YOU COLLABORATED WITH HERE
 * @brief structs, pointers, pointer arithmetic, arrays, strings, and macros
 * @date 2022-03-28
 */

// DO NOT MODIFY THE INCLUDE(S) LIST
#include <stdio.h>
#include "hw7.h"
#include "my_string.h"

// Global animals of Animal structs
struct animal animals[MAX_ANIMAL_LENGTH];

int size = 0;

/** addAnimal
 *
 * @brief creates a new Animal and adds it to the animals of Animal structs, "animals"
 *
 *
 * @param "species" species of the animal being created and added
 *               NOTE: if the length of the species (including the null terminating character)
 *               is above MAX_SPECIES_LENGTH, truncate species to MAX_SPECIES_LENGTH. If the length
 *               is 0, return FAILURE.
 *
 * @param "id" id of the animal being created and added
 * @param "hungerScale" hunger scale of the animal being created and added
 * @param "habitat" habitat of the animal being created and added
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "species" length is 0
 *         (2) "habitat" length is 0
 *         (3) adding the new animal would cause the size of the animals "animals" to
 *             exceed MAX_ANIMAL_LENGTH
 *
 */
int addAnimal(const char *species, int id, double hungerScale, const char *habitat)
{
  int incSize = size + 1;
  if ((my_strlen(species)) == 0 || (my_strlen(habitat)) == 0 || incSize > MAX_ANIMAL_LENGTH)
  {
    return FAILURE;
  }

  my_strncpy(animals[size].species, species, MAX_SPECIES_LENGTH - 1);
  animals[size].id = id;
  animals[size].hungerScale = hungerScale;
  my_strncpy(animals[size].habitat, habitat, MAX_HABITAT_LENGTH - 1);

  size++;

  return SUCCESS;
}

/** updateAnimalSpecies
 *
 * @brief updates the species of an existing animal in the animals of Animal structs, "animals"
 *
 * @param "animal" Animal struct that exists in the animals "animals"
 * @param "species" new species of Animal "animal"
 *               NOTE: if the length of species (including the null terminating character)
 *               is above MAX_SPECIES_LENGTH, truncate species to MAX_SPECIES_LENGTH
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the Animal struct "animal" can not be found in the animals "animals" based on its id
 */
int updateAnimalSpecies(struct animal animal, const char *species)
{
  printf("new species: %s\n", animal.species);
  int id = animal.id;
  printf("id: %d\n", id);
  for (int i = 0; i < size; i++)
  {
    if (animals[i].id == id)
    {
      my_strncpy(animals[i].species, species, MAX_SPECIES_LENGTH - 1);
      printf("new species: %s\n", animals[i].species);
      return SUCCESS;
    }
  }

  return FAILURE;
}

/** averageHungerScale
 * @brief Search for all animals with the same species and find average the hungerScales
 *
 * @param "species" Species that you want to find the average hungerScale for
 * @return the average hungerScale of the specified species
 *         if the species does not exist, return 0.0
 */
double averageHungerScale(const char *species)
{
  int count = 0;
  double totalHunger = 0.0;
  for (int i = 0; i < size; i++)
  {
    if (my_strncmp(animals[i].species, species, my_strlen(species)) == 0)
    {
      count++;
      totalHunger = totalHunger + animals[i].hungerScale;
    }
  }

  if (count != 0)
  {
    return totalHunger / count;
  }

  return 0.0;
}

/** swapAnimals
 *
 * @brief swaps the position of two Animal structs in the animals of Animal structs, "animals"
 *
 * @param "index1" index of the first Animal struct in the animals "animals"
 * @param "index2" index of the second Animal struct in the animals "animals"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) "index1" and/or "index2" are negative numbers
 *         (2) "index1" and/or "index2" are out of bounds of the animals "animals"
 */
int swapAnimals(int index1, int index2)
{
  if (index1 < 0 || index2 < 0 || index1 >= size || index2 >= size)
  {
    return FAILURE;
  }

  struct animal temp = animals[index1];
  animals[index1] = animals[index2];
  animals[index2] = temp;

  return SUCCESS;
}

/** compareHabitat
 *
 * @brief compares the two Animals animals' habitats (using ASCII)
 *
 * @param "animal1" Animal struct that exists in the animals "animals"
 * @param "animal2" Animal struct that exists in the animals "animals"
 * @return negative number if animal1 is less than animal2, positive number if animal1 is greater
 *         than animal2, and 0 if animal1 is equal to animal2
 */
int compareHabitat(struct animal animal1, struct animal animal2)
{
  int res = my_strncmp(animal1.habitat, animal2.habitat, MAX_HABITAT_LENGTH);
  return res;
}

/** removeAnimal
 *
 * @brief removes Animal in the animals of Animal structs, "animals", that has the same species
 *
 * @param "animal" Animal struct that exists in the animals "animals"
 * @return FAILURE on failure, SUCCESS on success
 *         Failure if any of the following are true:
 *         (1) the Animal struct "animal" can not be found in the animals "animals"
 */
int removeAnimal(struct animal animal)
{
  int id = animal.id;
  int index = 0;
  for (int i = 0; i < size; i++)
  {
    if (animals[i].id == id)
    {
      index = i;
      for (int i = index; i < MAX_ANIMAL_LENGTH; i++)
      {
        animals[i] = animals[i + 1];
      }
      size--;
      return SUCCESS;
    }
  }

  return FAILURE;
}

/** sortAnimal
 *
 * @brief using the compareHabitat function, sort the Animals in the animals of
 * Animal structs, "animals," by the animals' habitat
 * If two animals have the same habitat, place the hungier animal first
 *
 * @param void
 * @return void
 */
void sortAnimalsByHabitat(void)
{
  int i, j;
  int n = size;
  for (i = 0; i < n - 1; i++)
  {
    for (j = 0; j < n - i - 1; j++)
    {
      int comp = compareHabitat(animals[j], animals[j + 1]);
      if (comp == 1)
      {
        swapAnimals(j, j + 1);
      }
      if (comp == 0) 
      {
        if (animals[j].hungerScale < animals[j + 1].hungerScale)
        {
          swapAnimals(j, j + 1);
        }
      }
    }
  }
}
