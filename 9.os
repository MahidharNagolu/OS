#include <stdio.h>
#include <windows.h>

#define BUF_SIZE 256
#define SHARED_MEMORY_NAME "Local\\MySharedMemory"

int main() {
    HANDLE hMapFile;
    LPCTSTR pBuf;

    // Create a file mapping object
    hMapFile = CreateFileMapping(
        INVALID_HANDLE_VALUE,               // Use the page file
        NULL,                               // Default security
        PAGE_READWRITE,                     // Read/write access
        0,                                  // Maximum object size (high-order DWORD)
        BUF_SIZE,                           // Maximum object size (low-order DWORD)
        SHARED_MEMORY_NAME                  // Name of the mapping object
    );

    if (hMapFile == NULL) {
        printf("Could not create file mapping object (%d).\n", GetLastError());
        return 1;
    }

    // Map the shared memory into the process address space
    pBuf = (LPTSTR)MapViewOfFile(hMapFile, FILE_MAP_ALL_ACCESS, 0, 0, BUF_SIZE);
    if (pBuf == NULL) {
        printf("Could not map view of file (%d).\n", GetLastError());
        CloseHandle(hMapFile);
        return 1;
    }

    // Write to the shared memory
    sprintf((char*)pBuf, "Hello from the first process.");

    printf("Message written to shared memory: %s\n", (char*)pBuf);

    // Wait for a moment to allow another process to read the shared memory
    Sleep(5000);

    // Unmap the shared memory
    UnmapViewOfFile(pBuf);

    // Close the handle to the file mapping object
    CloseHandle(hMapFile);

    return 0;
}

