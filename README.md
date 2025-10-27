# Predicting Health Status from Gut Microbiome Profiles

Team Members : Anagha Krishna, Anushka Dongaonkar, Rutu Jaswanth Kothari, Arnav Gupte

## Project Description

This project investigates whether gut microbiome profiles can predict cardiometabolic disease status.

Specifically, we will compare two approaches:  
Diversity-based features: ecological metrics such as Shannon index, richness, and Simpson diversity.
Taxa-based features: species-level relative abundances.
In addition, we will analyze how antibiotic use and medical treatments influence gut microbiome diversity and composition, to understand external factors that might affect prediction accuracy. Concretely, we will:
1. Compare alpha diversity indices (Shannon, Richness) between antibiotic vs. non-antibiotic users.
2. Evaluate differences in gut microbial community structure after antibiotic use for each condition.
3. Examine whether treatments alter microbial composition in diseased individuals.

## Project Goals

Develop and evaluate machine learning models to classify Healthy vs Disease status from microbiome data.
Compare predictive performance of diversity-based features vs. taxa-based features.
Visualize microbiome differences between Healthy and Disease groups.
Assess the impact of antibiotic use on microbial diversity and community structure.
Examine the effect of treatments on microbial composition in diseased individuals.

Together, these analyses will show whether simple diversity measures are sufficient for disease prediction, or if detailed taxa-level profiles provide greater accuracy, while also highlighting how external factors shape the microbiome.

### Data

Source: curatedMetagenomicData R package.

Dataset: MetaCardis_2020_a (curated by Paolo Manghi).

Samples: 1,831 microbiome profiles from patients.

Features: 697 microbial taxa at the species level.

# Midterm Report
# 1. Preliminary Visualizations of Data

We began by exploring the gut microbiome dataset to understand its structure and variation. Using alpha and beta diversity analyses, we visualized the diversity patterns within and across samples.

* Alpha diversity (within-sample diversity) helped us measure how many distinct microbial species were present in each individual’s gut.
* Beta diversity (between-sample diversity) allowed us to compare microbial composition across different disease groups — including IGT, HF,   CAD, T2D, and healthy controls.
The visualizations showed overlapping diversity trends across groups, suggesting that microbial composition is highly individualized yet subtly influenced by disease status.

# 2. Detailed Description of Data Processing Done So Far

The dataset consisted of 1,800 patient samples with relative abundance values for around 600 microbial species.
To ensure high data quality:

* Microbes with more than 1% missing values were removed.
* Basic preprocessing such as normalization and handling of missing values was performed.
* The dataset required minimal cleaning overall, indicating good data integrity.
  This step ensured that downstream analyses such as diversity estimation and clustering were based on reliable, complete data.

# 3. Detailed Description of Data Modeling Methods Used So Far

We performed unsupervised learning techniques to uncover natural patterns in the data:

* Clustering analysis (using microbial composition features) was applied to check if patients naturally grouped by health condition.
* However, the resulting clusters were not clearly separable, indicating that microbial differences among disease conditions are subtle and complex rather than distinct.
Additionally, we performed statistical testing (Mann–Whitney U test) to identify microbes with significantly different abundances between disease groups.
These methods provided early insights into microbial patterns that may be relevant for future feature selection and predictive modeling.

# 4. Preliminary Results

No distinct clusters were observed in the unsupervised analyses, suggesting high inter-individual variability in gut microbiome composition.

Despite this, statistical comparisons revealed several microbial species that differ significantly between disease conditions, indicating potential biomarkers.

These early findings form the foundation for the next phase , applying supervised learning models to predict health status and assess which microbes contribute most to disease differentiation.  



