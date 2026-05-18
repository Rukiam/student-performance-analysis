# ── PART A Q1: Descriptive Statistics ──────────────────────────────

#Step 1: Load Our Dataset
data <- read.csv("C:/Users/hekllo/OneDrive/Documents/MMU/Sem (6)/Stastical/242UC24415_ALI RUKIA_Assignment1/student-mat.csv",
                 sep=";")
data <- read.csv("../data/student-mat.csv", sep=";")

# Step 2: Extract our variables
G1 <- data$G1
G3 <- data$G3

# Step 3: Define a Function to Calculate the Summary Statistics
Stat_Summary <- function(values) {
  values <- na.omit(values)  # Remove missing values
  
  # Mode calculation since its not build in R
  mode_value <- as.numeric(names(which.max(table(values))))
  if (length(mode_value) == 0) mode_value <- NA
  
  # Summary statistics
  summary_stats <- c(
    Mean = mean(values),
    Median = median(values),
    Mode = mode_value,
    Std_Dev = sd(values),
    Variance = var(values),
    Range = max(values) - min(values),
    Q1 = quantile(values, 0.25),
    Q3 = quantile(values, 0.75),
    IQR = IQR(values),
    CV = sd(values) / mean(values)
  )
  
  return(summary_stats)
}



# Step 4: Store the results then convert into a nice table
results_G1 <- Stat_Summary(G1)
results_G3 <- Stat_Summary(G3)


final_table <- data.frame(
  G1_Score = round(results_G1, 2),
  G3_Score = round(results_G3, 2)
)

# Step 5: Display
print(final_table)


# ── PART A Q3: Visualizations ─────────────────────────────────────

install.packages("ggplot2")
library(ggplot2)


# Histogram - G1
ggplot(data, aes(x = G1)) +
 geom_histogram(binwidth=1,fill = "pink",color= "black")+
 labs (title = "Histogram of G1 (First Period Grade)",
       x= "Grade",
       y= "Frequency") +
 theme(plot.title = element_text(hjust = 0.5,
                                 face = "bold") )
  
# Histogram - G3
ggplot(data, aes(x = G3)) +
  geom_histogram(binwidth=1, fill = "steelblue", color= "black") +
   labs (title = "Histogram of G3 (Final Grade)",
         x= "Grade",
         y= "Frequency" ) + 
   theme(
    plot.title = element_text(hjust = 0.5, face = "bold"))

# Boxplot - G1
ggplot(data, aes(y = G1)) +
  geom_boxplot(fill = "pink", color = "black") +
  labs(title = "Boxplot of G1", y = "Grade") +
  scale_y_continuous(breaks = seq(0, 20, 2)) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()
  )

# Boxplot - G3
ggplot(data, aes(y = G3)) +
  geom_boxplot(fill = "steelblue", color = "black") +
  labs(title = "Boxplot of G3", y = "Grade") +
  scale_y_continuous(breaks = seq(0, 20, 2)) +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold"),
    axis.text.x = element_blank(),
    axis.ticks.x = element_blank()
  )

# ── PART B Q2: Empirical Rule ────────────────────────────

# Remember we already selected G3 in the beginning
# G3 <- data$G3

mean_G3 <- mean(G3)
sd_G3   <- sd(G3)


cat("Mean of G3:", round(mean_G3, 4), "\n")
cat("SD of G3:  ", round(sd_G3, 4), "\n\n")

# ── Empirical Rule: proportion within 1, 2, 3 SDs ──
within_1sd <- sum(G3 >= (mean_G3 - sd_G3) & 
                    G3 <= (mean_G3 + sd_G3)) / length(G3) * 100

within_2sd <- sum(G3 >= (mean_G3 - 2*sd_G3) & 
                    G3 <= (mean_G3 + 2*sd_G3)) / length(G3) * 100

within_3sd <- sum(G3 >= (mean_G3 - 3*sd_G3) & 
                    G3 <= (mean_G3 + 3*sd_G3)) / length(G3) * 100

cat("Within 1 SD (expected ~68%):", round(within_1sd, 2), "%\n")
cat("Within 2 SD (expected ~95%):", round(within_2sd, 2), "%\n")
cat("Within 3 SD (expected ~99.7%):", round(within_3sd, 2), "%\n")

# ── PART B Q3: QQ-Plot & Shapiro-Wilk Test ───────────────────────

# QQ-Plot 
ggplot(data, aes(sample = G3)) +
  stat_qq(color = "steelblue", size = 1.5) +
  stat_qq_line(color = "black", linetype = "dashed", linewidth = 1) +
  labs(
    title = "Q-Q Plot of G3 (Final Grade)",
    x = "Theoretical Quantiles",
    y = "Sample Quantiles"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )





# Shapiro-Wilk Test
shapiro_result <- shapiro.test(G3)
cat("W statistic:", round(shapiro_result$statistic, 4), "\n")
cat("p-value:    ", round(shapiro_result$p.value, 6), "\n")
cat("\nDecision: If p < 0.05, reject normality\n")


# ── PART C Q1: Scatter Plot with Regression Line ─────────────────

ggplot(data, aes(x = G1, y = G3)) +
  geom_point(color = "steelblue", 
             alpha = 0.6, 
             size = 2) +
  geom_smooth(method = "lm", 
              color = "red", 
              se = FALSE,
              linewidth = 1) +
  labs(
    title = "Scatter Plot of G1 vs G3 with Regression Line",
    x = "G1 - First Period Grade",
    y = "G3 - Final Grade"
  ) +
  scale_x_continuous(breaks = seq(0, 20, 2)) +
  scale_y_continuous(breaks = seq(0, 20, 2)) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, face = "bold")
  )


# ── PART C Q2: Pearson Correlation ───────────────────────────────

# Step 1: Calculate deviations from the mean
x <- G1 - mean(G1)
y <- G3 - mean(G3)

# Step 2: Calculate Sxx, Syy, and Sxy
Sxx <- sum(x^2)
Syy <- sum(y^2)
Sxy <- sum(x * y)

# Step 3: Calculate Pearson correlation coefficient (r)
r <- Sxy / sqrt(Sxx * Syy)

# Step 4: Calculate coefficient of determination (r²)
r2 <- r^2

# Step 5: Verify using built-in R function
r_builtin <- cor(G1, G3, method = "pearson")

# Step 6: Display results
cat("Pearson Correlation (Manual Calculation):\n")
cat("─────────────────────────────────────────\n")
cat("Sxx:", round(Sxx, 4), "\n")
cat("Syy:", round(Syy, 4), "\n")
cat("Sxy:", round(Sxy, 4), "\n")
cat("r  :", round(r, 4), "\n")
cat("r² :", round(r2, 4), "\n\n")

cat("Verification using cor() function:\n")
cat("r (built-in):", round(r_builtin, 4), "\n")









