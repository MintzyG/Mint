#include <stdlib.h>
#include <stddef.h>
#include <string.h>

int parse_decimal(const char *text) {
    char *clean = strdup(text);
    char *p = clean;
    int result;

    // Remove underscores
    char *write = clean;
    while (*p) {
        if (*p != '_') *write++ = *p;
        p++;
    }
    *write = '\0';

    result = (int)strtoll(clean, NULL, 10);
    free(clean);
    return result;
}

int parse_octal(const char *text) {
    char *clean = strdup(text);
    char *p = clean;
    int result;

    // Skip "0o" or "0O" prefix if present
    if (text[1] == 'o' || text[1] == 'O') p += 2;

    // Remove underscores
    char *write = clean;
    while (*p) {
        if (*p != '_') *write++ = *p;
        p++;
    }
    *write = '\0';

    result = (int)strtoll(clean, NULL, 8);
    free(clean);
    return result;
}

int parse_hex(const char *text) {
    char *clean = strdup(text);
    char *p = clean;
    int result;

    // Skip "0x" or "0X" prefix
    if (text[1] == 'x' || text[1] == 'X') p += 2;

    // Remove underscores
    char *write = clean;
    while (*p) {
        if (*p != '_') *write++ = *p;
        p++;
    }
    *write = '\0';

    result = (int)strtoll(clean, NULL, 16);
    free(clean);
    return result;
}

int parse_binary(const char *text) {
    char *clean = strdup(text);
    char *p = clean;
    int result = 0;

    // Skip "0b" or "0B" prefix
    if (text[1] == 'b' || text[1] == 'B') p += 2;

    // Parse manually (since strtoll with base 2 is less common)
    while (*p) {
        if (*p != '_') {
            if (*p == '1') result = (result << 1) | 1;
            else if (*p == '0') result = result << 1;
            else { /* error */ }
        }
        p++;
    }

    free(clean);
    return result;
}

