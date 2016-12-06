#include <stdio.h>

const int numpad[3][3] = {
	{1, 2, 3},
	{4, 5, 6},
	{7, 8, 9}
};

int main() {
	char c;
	int cur_x = 1, cur_y = 1;
	while ((c = fgetc(stdin)) != EOF) {
		if (c == 'U') {
			cur_x--;
			if (cur_x < 0) cur_x = 0;
		} else if (c == 'D') {
			cur_x++;
			if (cur_x > 2) cur_x = 2;
		} else if (c == 'L') {
			cur_y--;
			if (cur_y < 0) cur_y = 0;
		} else if (c == 'R') {
			cur_y++;
			if (cur_y > 2) cur_y = 2;
		} else {
			printf("%d", numpad[cur_x][cur_y]);
		}	
	}
	return 0;
}
