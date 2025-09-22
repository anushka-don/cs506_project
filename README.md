# Predicting Health Status from Gut Microbiome Profiles

Team Members : Anagha Krishna, Anushka Dongaonkar, Rutu Jaswanth Kothari, Arnav Gupte

## Project Description

This project investigates whether gut microbiome profiles can predict cardiometabolic disease status.

Specifically, we will compare two approaches:
Diversity-based features: ecological metrics such as Shannon index, richness, and Simpson diversity.
Taxa-based features: species-level relative abundances.

In addition, we will analyze how antibiotic use and treatments influence gut microbiome diversity and composition, to understand external factors that might affect prediction accuracy.

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

Samples: 1,831 microbiome profile from patients.

Features: 697 microbial taxa at the species level.

### Metadata Labels

Healthy: controls without diagnosed conditions.

Disease: pooled cardiometabolic conditions — CAD (Coronary Artery Disease), HF (Heart Failure), IGT (Impaired Glucose Tolerance), MS (Metabolic Syndrome), T2D (Type 2 Diabetes).

## Data Cleaning
Remove samples with missing disease labels or extreme missingness.
Filter rare taxa (e.g., present in <1–5% of samples).
Normalize abundances and apply appropriate transformations for compositional data.
Handle missing metadata values appropriately.

## Modeling Plan
Task: Classification (Healthy vs Disease conditions).
Models: Logistic Regression, Random Forest, XGBoost (subject to change as we learn more)
### Features
Diversity-based features (Shannon, Simpson, Richness).
Taxa-based features (species-level abundances after transformation).

## Visualization Plan
Box/Violin Plots: Diversity indices across Healthy vs Disease, and stratified by antibiotic use/treatments.
Stacked Bar Plots: Top 10–15 most abundant taxa in Healthy vs Disease groups.
Heatmaps: Most variable taxa across samples.
PCA and UMAP Plots: Low-dimensional visualization of taxa-based features, colored by health status.

## Test Plan
Withhold 20% of labeled data as a fixed test set.
Train models on the remaining 80% using k-fold cross-validation (mostly 5-fold CV).
Evaluate models with Accuracy, Precision, Recall, F1-score, and ROC-AUC.
Compare diversity-based vs taxa-based approaches
