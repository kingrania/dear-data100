// Dear Data 100 - Processing sketch
// Data file: data/data.csv with columns date,category,value

Table table;
ArrayList<Item> items = new ArrayList<Item>();
float maxValue = 1;

void setup() {
  size(800, 800);
  colorMode(HSB, 360, 100, 100);
  table = loadTable("data.csv", "header");

  // One object per row of data
  for (TableRow row : table.rows()) {
    Item it = new Item(row.getString("date"), row.getString("category"), row.getFloat("value"));
    items.add(it);
    maxValue = max(maxValue, it.value);
  }
}

void draw() {
  background(0, 0, 97);
  int cols = 10;                       // 10 x 10 grid = 100 items
  float cell = width / (float) cols;

  for (int i = 0; i < items.size(); i++) {
    float x = (i % cols) * cell + cell / 2;
    float y = (i / cols) * cell + cell / 2;
    items.get(i).display(x, y, cell);
  }

  fill(0, 0, 20);
  text(items.size() + " items", 10, height - 10);
}

class Item {
  String date;
  String category;
  float value;

  Item(String d, String c, float v) {
    date = d;
    category = c;
    value = v;
  }

  // A method that returns a value: picks a colour based on the category
  color colour() {
    float hue = abs(category.hashCode()) % 360;
    return color(hue, 70, 90);
  }

  // A method that returns a value: circle size based on the value
  float size(float cell) {
    return map(value, 0, maxValue, cell * 0.15, cell * 0.9);
  }

  void display(float x, float y, float cell) {
    noStroke();
    fill(colour());
    circle(x, y, size(cell));
  }
}
