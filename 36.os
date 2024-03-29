#include <stdio.h>
#include <stdlib.h>

// Define structures
typedef struct Block {
    int blockNumber;
    struct Block* nextBlock;
} Block;

typedef struct File {
    int fileId;
    Block* firstBlock;
    Block* lastBlock;
} File;

typedef struct Directory {
    File* files;
    int fileCount;
} Directory;

// Function prototypes
void initializeDirectory(Directory* directory);
File* createFile(Directory* directory);
void allocateBlock(File* file);
void deallocateFile(File* file);
void displayDirectory(Directory* directory);

// Main function
int main() {
    Directory directory;
    initializeDirectory(&directory);

    File* file1 = createFile(&directory);
    File* file2 = createFile(&directory);

    allocateBlock(file1);
    allocateBlock(file1);
    allocateBlock(file2);

    displayDirectory(&directory);

    deallocateFile(file1);
    displayDirectory(&directory);

    return 0;
}

// Function to initialize the directory
void initializeDirectory(Directory* directory) {
    directory->files = NULL;
    directory->fileCount = 0;
}

// Function to create a new file
File* createFile(Directory* directory) {
    directory->fileCount++;
    directory->files = (File*)realloc(directory->files, directory->fileCount * sizeof(File));


    File* newFile = &(directory->files[directory->fileCount - 1]);
    newFile->fileId = directory->fileCount;
    newFile->firstBlock = NULL;
    newFile->lastBlock = NULL;

    return newFile;
}

// Function to allocate a block for a file
void allocateBlock(File* file) {
    Block* newBlock = (Block*)malloc(sizeof(Block));

    newBlock->blockNumber = rand() % 1000; // Random block number for simplicity
    newBlock->nextBlock = NULL;

    if (file->lastBlock == NULL) {
        file->firstBlock = newBlock;
        file->lastBlock = newBlock;
    } else {
        file->lastBlock->nextBlock = newBlock;
        file->lastBlock = newBlock;
    }
}

// Function to deallocate a file and its blocks
void deallocateFile(File* file) {
    Block* currentBlock = file->firstBlock;
    Block* nextBlock;

    while (currentBlock != NULL) {
        nextBlock = currentBlock->nextBlock;
        free(currentBlock);
        currentBlock = nextBlock;
    }

    file->firstBlock = NULL;
    file->lastBlock = NULL;
}

// Function to display the directory contents
void displayDirectory(Directory* directory) {
    printf("\nDirectory Contents:\n");

    for (int i = 0; i < directory->fileCount; i++) {
        File* file = &(directory->files[i]);
        printf("File %d:\n", file->fileId);

        Block* currentBlock = file->firstBlock;
        while (currentBlock != NULL) {
            printf("  Block %d\n", currentBlock->blockNumber);
            currentBlock = currentBlock->nextBlock;
        }
    }

    printf("\n");
}
