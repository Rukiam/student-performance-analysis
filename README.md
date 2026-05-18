# student-performance-analysis

 Student Performance — Statistical Data Analysis

Exploratory and descriptive statistical analysis of student academic performance
using R, covering distributional assessment, normality testing, and bivariate correlation.


 Project Overview
This project was completed as part of CDS6224: Statistical Data Analysis and applies core statistical techniques to a real-world educational dataset. The analysis investigates whether a student's first-period grade (G1) is a reliable predictor of their final grade (G3), and explores the distributional properties of both variables.
Key questions explored:

How consistent are students' grades between the first and final grading periods?
Does final grade (G3) follow a normal distribution?
How strongly are G1 and G3 linearly associated?


Repository Structure
student-performance-analysis/
│
├── README.md
├── data/
│   └── student-mat.csv          # Raw dataset (UCI ML Repository)
├── scripts/
│   └── analysis.R               # Full R script (Parts A–D)


 Dataset
Source: UCI Machine Learning Repository — Student Performance
Reference: Cortez & Silva, 2008
Size: 395 observations, 33 variables
Key variables used:
VariableDescriptionTypeG1First-period grade (0–20)NumericalG3Final grade (0–20)NumericalsexStudent gender (M/F)Categorical

 Analysis Summary
Part A — Exploratory Descriptive Analysis

Computed descriptive statistics: mean, median, mode, SD, variance, range, IQR, and CV for G1 and G3
Found G1 (CV = 0.30) to be more consistent than G3 (CV = 0.44)
Visualized distributions using histograms and boxplots; identified a notable spike at G3 = 0

Part B — Distributional Assessment

Applied the empirical rule: 69.87% within 1 SD, 90.13% within 2 SD, 100% within 3 SD
QQ-plot revealed deviation at the lower tail due to zero scores
Shapiro-Wilk test (W = 0.9287, p ≈ 0) confirmed G3 is not normally distributed

Part C — Bivariate Relationship Analysis

Scatter plot with regression line showed a clear positive linear trend
Pearson correlation: r = 0.8015 (strong positive association)
Coefficient of determination: r² = 0.6424 (64.24% of G3 variance explained by G1)
Relationship interpreted as associative, not causal

Part D — Critical Reflection

Communicated findings for a non-technical audience
Discussed limitations of descriptive statistics and the role of inferential methods
Reflected on how visualizations reveal patterns beyond numerical summaries


 Tools & Libraries

Language: R
IDE: RStudio
Libraries: ggplot2


 How to Run

Clone this repository:

bash   git clone https://github.com/Rukiam/student-performance-analysis.git

Open scripts/analysis.R in RStudio
Make sure ggplot2 is installed:

r   install.packages("ggplot2")

The script reads data from the relative path ../data/student-mat.csv — no changes needed if folder structure is maintained
