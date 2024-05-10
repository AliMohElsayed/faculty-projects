PImage mapImage; // Declaring a variable to store an image
int rowCount;   // Declaring a variable to store the number of rows in the data
Table data;    // Declaring a variable to store tabular data
float dataMin = MAX_FLOAT;
float dataMax = MIN_FLOAT;
String message = "";   // Declaring an empty string variable to store a message

void setup() {
  size(470, 350);
  mapImage = loadImage("EGY.jpg");  // Loading an image named "egypt.jpg"
  data = new Table("data.tsv");      // Loading tabular data from a file named "data.tsv"
  rowCount = data.getRowCount();    // Getting the number of rows in the data table
  
  // Find the minimum and maximum values.
  for (int row = 0; row < rowCount; row++) {  
    float value = data.getFloat(row, 4);    // Getting a float value from the 4th column of the current row
    if (value > dataMax) {
      dataMax = value;
    }                               // Updating the max and min value 
    if (value < dataMin) {
      dataMin = value;
    }}
    // Resize the map image to fit the window
      mapImage.resize(width, height);
  }
    
void draw() {
  background(255);    // Set background color to white
  image(mapImage, 0, 0);
  smooth();
  for (int row = 0; row < rowCount; row++) {
    String abbrev = data.getRowName(row);      //the abbreviation from the current row
    float x = data.getFloat(abbrev, 2);    // Get the x-coordinate from the 2nd column of the current row
    float y = data.getFloat(abbrev, 3);  // Get the y-coordinate from the 3rd column of the current row
    drawData(x, y, abbrev);              // Set fill color to black
  }
  
  if (!message.equals("")) {      // Draw the message
    fill(0);
    textSize(14);
    textAlign(CENTER);
    text(message, width / 2, height - 20);
  }}
void drawData(float x, float y, String abbrev) {
  String governmentName = data.getString(abbrev, 1); // Get government name from column index 1
  float value = data.getFloat(abbrev, 4);    // Get data value from the 4th column
  float percent = norm(value, dataMin, dataMax);
  color between = lerpColor(#87CEEB, #800080, percent); // Sky Blue to Purple
  fill(between);     //Set fill color to interpolated color 
  ellipse(x, y, 7, 7);
}

void mouseClicked() {
  for (int row = 0; row < rowCount; row++) {
    String abbrev = data.getRowName(row);      //Get the abbreviation from the current row
    float x = data.getFloat(abbrev, 2);        // Get the x-coordinate from the 2nd column of the current row
    float y = data.getFloat(abbrev, 3);      // Get the y-coordinate from the 3rd column of the current row

    
    if (dist(x, y, mouseX, mouseY) < 7 / 2) { // Check if mouse is over the point
      displayData(abbrev);                    // If mouse is over the point, display data for that point
      break;
    }
  }
}
  
void displayData(String abbrev) {            // Function to display data for a given abbreviation
  String governmentName = data.getString(abbrev, 1); // Assuming government names are in column index 1
  float value = data.getFloat(abbrev, 4);
   // Construct the message to display
  message = "Name of Government : " + governmentName + "\n population num: " + nf(value, 0, 2);         
}
