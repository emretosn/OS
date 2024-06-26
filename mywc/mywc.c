#include <stdio.h>
#include <ctype.h>
/* In lieu of a boolean data type. */
enum {FALSE, TRUE};
static long lLineCount = 0;
static long lWordCount = 0;
static long lCharCount = 0;
static int iChar;
static int iInWord = FALSE;
/* Write to stdout counts of how many lines, words, and characters
are in stdin. A word is a sequence of non-whitespace characters.
Whitespace is defined by the isspace() function. Return 0. */
int main(int, char **) {
	while ((iChar = getchar()) != EOF) {
		lCharCount++;
		if (isspace(iChar)) {
			if (iInWord) {
				lWordCount++;
				iInWord = FALSE;
			}
		}
		else {
			if (! iInWord) {
				iInWord = TRUE;
			}
		}
		if (iChar == '\n') {
			lLineCount++;
		}
	}
	if (iInWord) {
		lWordCount++;
	}
	printf("%7ld %7ld %7ld\n", lLineCount, lWordCount, lCharCount);
	return 0;
}
