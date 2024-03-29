include <stdio.h>
#include <stdlib.h>

void scan(int request[], int n, int head, int direction) {
    int totalSeek = 0;
    int current = head;

    int minSeek = 0, maxSeek = 199;  // assuming disk size is 200

    printf("Seek sequence using SCAN: ");

    if (direction == 0) {
        for (int i = head; i >= minSeek; i--) {
            printf("%d ", i);
            totalSeek += abs(current - i);
            current = i;
        }
        current = minSeek;
    } else {
        for (int i = head; i <= maxSeek; i++) {
            printf("%d ", i);
            totalSeek += abs(current - i);
            current = i;
        }
        current = maxSeek;
    }

    for (int i = 0; i < n; i++) {
        printf("%d ", request[i]);
        totalSeek += abs(current - request[i]);
        current = request[i];
    }

    printf("\nTotal seek distance using SCAN: %d\n", totalSeek);
}

int main() {
    int n, head, direction;

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

    printf("Enter the direction (0 for left, 1 for right): ");
    scanf("%d", &direction);

    scan(request, n, head, direction);

    return 0;
}
