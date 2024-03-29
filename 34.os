#include <stdio.h>
#include <stdlib.h>

#define MAX_RECORDS 100

// Structure to represent a record in the file
struct Record {
    int id;
    char data[50]; // Assuming a maximum of 50 characters of data for each record
};

// Function to simulate reading records sequentially
void readSequentially(struct Record records[], int numRecords) {
    for (int i = 0; i < numRecords; i++) {
        printf("Record ID: %d, Data: %s\n", records[i].id, records[i].data);
    }
}

int main() {
    int numRecords;
    
    // Input the number of records in the file
    printf("Enter the number of records in the file: ");
    scanf("%d", &numRecords);

    if (numRecords <= 0 || numRecords > MAX_RECORDS) {
        printf("Invalid number of records. Please enter a value between 1 and %d.\n", MAX_RECORDS);
        return 1; // Exit with an error code
    }

    // Create an array of records
    struct Record records[MAX_RECORDS];

    // Input records data
    for (int i = 0; i < numRecords; i++) {
        records[i].id = i + 1; // Record ID starts from 1
        printf("Enter data for Record %d: ", records[i].id);
        scanf("%s", records[i].data);
    }

    // Simulate reading records sequentially
    printf("\nReading records sequentially:\n");
    readSequentially(records, numRecords);

    return 0;
}
