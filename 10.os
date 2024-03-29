#include <stdio.h>
#include <windows.h>

#define BUFFER_SIZE 1024
#define PIPE_NAME L"\\\\.\\pipe\\MyNamedPipe"

int main() {
    HANDLE hPipe;
    DWORD dwBytesRead;
    char buffer[BUFFER_SIZE];

    // Create the named pipe
    hPipe = CreateNamedPipe(
        PIPE_NAME,
        PIPE_ACCESS_DUPLEX,
        PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT,
        PIPE_UNLIMITED_INSTANCES,
        BUFFER_SIZE,
        BUFFER_SIZE,
        0,
        NULL
    );

    if (hPipe == INVALID_HANDLE_VALUE) {
        printf("Failed to create named pipe. Error code: %d\n", GetLastError());
        return 1;
    }

    printf("Named pipe created. Waiting for connection...\n");

    // Wait for the client to connect
    if (!ConnectNamedPipe(hPipe, NULL)) {
        printf("Failed to connect to named pipe. Error code: %d\n", GetLastError());
        CloseHandle(hPipe);
        return 1;
    }

    printf("Client connected. Waiting for message...\n");

    // Read message from the client
    if (!ReadFile(hPipe, buffer, BUFFER_SIZE, &dwBytesRead, NULL)) {
        printf("Failed to read from pipe. Error code: %d\n", GetLastError());
        CloseHandle(hPipe);
        return 1;
    }

    printf("Received message from client: %s\n", buffer);

    // Close the pipe handle
    CloseHandle(hPipe);

    return 0;
}
