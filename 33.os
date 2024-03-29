#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_PAGES 100
#define MAX_FRAMES 10

int pageFaults = 0;

// Function to find the optimal page to replace
int findOptimalPage(int pages[], int n, int index, int frame[]) {
    int res = -1, farthest = index;
    for (int i = 0; i < MAX_FRAMES; i++) {
        int j;
        for (j = index; j < n; j++) {
            if (frame[i] == pages[j]) {
                if (j > farthest) {
                    farthest = j;
                    res = i;
                }
                break;
            }
        }
        // If the page is not referenced in the future, return it
        if (j == n)
            return i;
    }
    return (res == -1) ? 0 : res;
}

// Function to simulate optimal paging
void optimalPageReplacement(int pages[], int n, int capacity) {
    int frame[MAX_FRAMES];
    bool inFrame[MAX_PAGES] = {false};

    for (int i = 0; i < n; i++) {
        if (!inFrame[pages[i]]) {
            int replaceIndex = findOptimalPage(pages, n, i + 1, frame);
            inFrame[frame[replaceIndex]] = false;
            frame[replaceIndex] = pages[i];
            inFrame[pages[i]] = true;
            pageFaults++;
        }
    }
}

int main() {
    int n, pages[MAX_PAGES];

    // Input the number of pages
    printf("Enter the number of pages: ");
    scanf("%d", &n);

    // Input the page reference string
    printf("Enter the page reference string:\n");
    for (int i = 0; i < n; i++) {
        scanf("%d", &pages[i]);
    }

    // Simulate optimal paging
    optimalPageReplacement(pages, n, MAX_FRAMES);

    // Display the number of page faults
    printf("Number of page faults using Optimal Paging: %d\n", pageFaults);

    return 0;
}
