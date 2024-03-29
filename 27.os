#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>

int main(int argc, char *argv[]) {
    // Define a pointer to a directory stream
    DIR *directory;
    // Define a pointer to the dirent structure
    struct dirent *entry;

    // Open the current directory
    directory = opendir(".");

    // Check if the directory could be opened
    if (directory == NULL) {
        perror("Unable to open directory");
        exit(EXIT_FAILURE);
    }

    // Loop through each entry in the directory
    while ((entry = readdir(directory)) != NULL) {
        // Print the name of the entry
        printf("%s\n", entry->d_name);
    }

    // Close the directory stream
    closedir(directory);

    return 0;
}
