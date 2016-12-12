int length;
int height;
bool[,] lcd;

public class LCD : GLib.Object {
  private int length;
  private int height;
  private bool[,] matrix;

  public LCD(int l, int h) {
    this.length = l;
    this.height = h;
    this.matrix = new bool[l,h];
  }

  public void print() {
    for (int i = 0; i < this.length; i++) {
      for (int j = 0; j < this.height; j++) {
        if (this.matrix[i,j]) {
          stdout.printf("#");
        } else {
          stdout.printf(".");
        }
      }
      stdout.printf("\n");
    }
  }

  public void rect(int width, int height) {
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < height; j++) {
        this.matrix[j,i] = true;
      }
    }
  }

  public void shiftCol(int col, int by) {
    bool[] col_copy = new bool[this.length];
    for (int i = 0; i < this.length; i++) {
      int y = i - by;
      while (y < 0) y += this.length;
      col_copy[i] = this.matrix[y,col];
    }
    for (int i = 0; i < this.length; i++) {
      this.matrix[i, col] = col_copy[i];
    }
  }

  public void shiftRow(int row, int by) {
    bool[] row_copy = new bool[this.height];
    for (int i = 0; i < this.height; i++) {
      int x = i - by;
      while (x < 0) x += this.height;
      row_copy[i] = this.matrix[row,x];
    }
    for (int i = 0; i < this.height; i++) {
      this.matrix[row, i] = row_copy[i];
    }
  }

  public int count() {
    int counter = 0;
    for (int i = 0; i < this.length; i++) {
      for (int j = 0; j < this.height; j++) {
        if (this.matrix[i,j]) counter++;
      }
    }
    return counter;
  }
}

public static void main (string[] args) {
  length = int.parse(args[1]);
  height = int.parse(args[2]);
  string filename = args[3];
  LCD lcd = new LCD(length,height);

  var file = FileStream.open(filename, "r");
  string line = file.read_line();
  while (line != null) {
    processLine(line, lcd);
    line = file.read_line();
  }

  lcd.print();
  stdout.printf("%d\n", lcd.count());
}

void processLine (string line, LCD lcd) {
  MatchInfo info;
  var rect_regex = new Regex("rect ([0-9]+)x([0-9]+)");
  var col_regex = new Regex("rotate column x=([0-9]+) by ([0-9]+)");
  var row_regex = new Regex("rotate row y=([0-9]+) by ([0-9]+)");

  if (rect_regex.match(line, 0, out info)) {
    int w = int.parse(info.fetch(1));
    int h = int.parse(info.fetch(2));

    lcd.rect(w, h);
  } else if (col_regex.match(line, 0, out info)) {
    int col = int.parse(info.fetch(1));
    int by = int.parse(info.fetch(2));

    lcd.shiftCol(col, by);
  } else if (row_regex.match(line, 0, out info)) {
    int row = int.parse(info.fetch(1));
    int by = int.parse(info.fetch(2));

    lcd.shiftRow(row, by);
  }
}
