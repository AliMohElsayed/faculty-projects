# Load the readxl package
library(readxl)

# Read the Excel file containing the x and y sequences
# Replace "input.xlsx" with the path to your Excel file
data <- read_excel("input.xlsx")

# Extract x and y sequences from the data frame
x_sequence <- data[["x_sequence"]]
y_sequence <- data[["y_sequence"]]

x_sequence
# Check if the lengths of x and y sequences match
if (length(x_sequence) != length(y_sequence)) {
  stop("Length of x sequence must match length of y sequence.")
}

# Calculate distances from the origin for all points
distances <- sqrt(1 - x_sequence^2)

# Initialize an empty vector to store colors
colors <- ifelse(distances > y_sequence, "red", "black")

# Calculate the decision for each point
decisions <- ifelse(distances > y_sequence, "IN", "OUT")

# Create a data frame with the columns
data <- data.frame(
  "First Random Number (X)" = x_sequence,
  "Second Random Number (Y)" = y_sequence,
  "Distances" = distances,
  "Decision" = decisions
)

# Save the data frame to a CSV file
write.csv(data, "output.csv", row.names = TRUE)

# Display the data frame
print(data)

# Save the plot as a PNG image
png("output.png", width = 1600, height = 1400, units = "px", res = 300)
plot(x_sequence, y_sequence, pch = 20, col = colors)
dev.off()

# Count the number of "OUT" decisions
M <- sum(decisions == "IN")

# Calculate the count of iterations
N <- length(x_sequence)

# Calculate the estimated value of Pi
estimated_pi <- (M/N)*4

# Print the estimated value of Pi
cat("The value of Pi is estimated to be:", estimated_pi, "\n")
