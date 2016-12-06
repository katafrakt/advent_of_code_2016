#include <stdio.h>

const char numpad[5][5] = {
	{0, 0, '1', 0, 0 },
	{0, '2', '3', '4', 0},
	{'5', '6', '7', '8', '9'},
	{0, 'A', 'B', 'C', 0},
	{0, 0, 'D', 0, 0}
};

int main() {
	char c;
	int cur_x = 2, cur_y = 2, x, y;
	while ((c = fgetc(stdin)) != EOF) {
		x = cur_x; y = cur_y;
		if (c == 'U') {
			x = cur_x - 1;
			if (x < 0 || numpad[x][y] == 0) x = cur_x;
		} else if (c == 'D') {
			x = cur_x + 1;
			if (x > 5 || numpad[x][y] == 0) x = cur_x;
		} else if (c == 'L') {
			y = cur_y - 1;
			if (y < 0 || numpad[x][y] == 0) y = cur_y;
		} else if (c == 'R') {
			y = cur_y + 1;
			if (cur_y > 5 || numpad[x][y] == 0) y = cur_y;
		} else {
			printf("%c", numpad[cur_x][cur_y]);
		}	
		cur_x = x; cur_y = y;
	}
	return 0;
}
