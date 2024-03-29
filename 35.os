#include <stdio.h>
#include <stdlib.h>

#define MAX_BLOCKS 100

// Structure to represent a block in the file
struct Block {
    int blockNumber;
    char data[50]; // Assuming a maximum of 50 characters of data for each block
};

// Structure to represent the index block
struct IndexBlock {
    int numBlocks;
    int blockPointers[MAX_BLOCKS];
};

// Function to simulate reading blocks using the index
void readUsingIndex(struct Block blocks[], struct IndexBlock indexBlock) {
    for (int i = 0; i < indexBlock.numBlocks; i++) {
        int blockNumber = indexBlock.blockPointers[i];
        printf("Block Number: %d, Data: %s\n", blockNumber, blocks[blockNumber - 1].data);
    }
}

int main() {
    int numBlocks;
    
    // Input the number of blocks in the file
    printf("Enter the number of blocks in the file: ");
    scanf("%d", &numBlocks);

    if (numBlocks <= 0 || numBlocks > MAX_BLOCKS) {
        printf("Invalid number of blocks. Please enter a value between 1 and %d.\n", MAX_BLOCKS);
        return 1; // Exit with an error code
    }

    // Create an array of blocks
    struct Block blocks[MAX_BLOCKS];

    // Input data for each block
    for (int i = 0; i < numBlocks; i++) {
        blocks[i].blockNumber = i + 1; // Block number starts from 1
        printf("Enter data for Block %d: ", blocks[i].blockNumber);
        scanf("%s", blocks[i].data);
    }

    // Create an index block
    struct IndexBlock indexBlock;
    indexBlock.numBlocks = numBlocks;

    // Initialize index block pointers
    for (int i = 0; i < numBlocks; i++) {
        indexBlock.blockPointers[i] = i + 1; // Pointers to blocks (assuming block numbers start from 1)
    }

    // Simulate reading blocks using the index
    printf("\nReading blocks using the index:\n");
    readUsingIndex(blocks, indexBlock);

    return 0;
}
