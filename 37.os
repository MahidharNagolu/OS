#include <stdio.h>
#include <stdlib.h>

void fcfs(int request[], int n, int head) {
    int totalSeek = 0;
    int current = head;

    printf("Seek sequence using FCFS: ");
    for (int i = 0; i < n; i++) {
        printf("%d ", current);
        totalSeek += abs(current - request[i]);
        current = request[i];
    }

    printf("\nTotal seek distance using FCFS: %d\n", totalSeek);
}

int main() {
    int n, head;

    printf("Enter the number of disk requests: ");
    scanf("%d", &n);

    int request[n];

    printf("Enter the disk request sequence:\n");
    for (int i = 0; i < n; i++) {
        printf("Request %d: ", i + 1);
        scanf("%d", &request[i]);
    }

    printf("Enter the initial position of the disk head: ");
    scanf("%d", &head);

    fcfs(request, n, head);

    return 0;
}
