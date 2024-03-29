#include <stdio.h>

int main() {
    FILE *file = fopen("my_file.txt", "w"); 
    if (file) {
        fprintf(file, "Hello, world!\n");
        fclose(file);

        // Open the file for reading
        file = fopen("my_file.txt", "r");
        if (file) {
            char buffer[100];
            // Read and print the content of the file
            while (fgets(buffer, sizeof(buffer), file)) {
                printf("%s", buffer);
            }
            fclose(file);
        } else {
            printf("Error opening file for reading.\n");
        }
    } else {
        printf("Error opening file for writing.\n");
    }
    return 0;
}
