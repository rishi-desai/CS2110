/**
 * @file main.c
 * @author YOUR NAME HERE
 * @brief testing and debugging functions written in my_string.c and hw7.c
 * @date 2021-06-xx
 */

// You may add and remove includes as necessary to help facilitate your testing
#include <stdio.h>
#include "hw7.h"
#include "my_string.h"

/** main
 *
 * @brief used for testing and debugging functions written in my_string.c and hw7.c
 *
 * @param void
 * @return 0 on success
 */
int main(void)
{

  addAnimal("monkey", 1, 1.3, "jungle");

  addAnimal("turtle", 2, 1.9, "jungle");

  addAnimal("lion", 3, 1.0, "jungle");

  printf("animal0: %s\n", animals[0].species);
  printf("animal1: %s\n", animals[1].species);
  printf("animal2: %s\n\n", animals[2].species);

  sortAnimalsByHabitat();

  printf("animal0: %s\n", animals[0].species);
  printf("animal1: %s\n", animals[1].species);
  printf("animal2: %s\n", animals[2].species);

  return 0;
}
