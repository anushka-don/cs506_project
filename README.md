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

### Metadata Labels

Healthy: controls without diagnosed conditions.

Disease: pooled cardiometabolic conditions — CAD (Coronary Artery Disease), HF (Heart Failure), IGT (Impaired Glucose Tolerance), MS (Metabolic Syndrome), T2D (Type 2 Diabetes).

## Data Cleaning
Remove samples with missing disease labels or extreme missingness.
Filter rare taxa (e.g., present in <1–5% of samples).
Normalize abundances and apply appropriate transformations for compositional data.
Handle missing metadata values appropriately.

## Data Preparation
Address sparsity using regularization (LASSO or Elastic Net).
Apply dimensionality reduction (e.g., PCA, t-SNE, or UMAP) to explore high-dimensional feature spaces.
Evaluate the effect of different rare taxa filtering thresholds (1% vs. 5%) on model performance and feature sets.
 

## Feature extraction and selection
Pre-modeling filtering: variance filtering and prevalence filtering.
Regularized models: LASSO or Elastic Net for feature shrinkage and selection.
Dimensionality reduction: PCA, UMAP, or t-SNE to identify global patterns.
Feature importance analysis: SHAP values, tree-based feature importance (RF/XGBoost), and stability plots across cross-validation.
Differential abundance testing: ANCOM-BC, DESeq2.



## Modeling Plan
Task: Binary classification (Healthy vs. Disease).
Models: Logistic Regression, Random Forest, XGBoost (subject to revision as we iterate).
Evaluation: Compare diversity-based vs. taxa-based feature sets, and assess the effect of antibiotic/treatment metadata on predictive performance.

### Features
Diversity-based features (Shannon, Simpson, Richness).
Taxa-based features (species-level abundances after transformation).

## Visualization Plan
Pre-modeling visualizations to explore features and trends:
Correlation heatmap of top abundant taxa.
PCA/UMAP plots colored by metadata (Healthy/Disease, antibiotics, treatments).
Post modelling visualizations:
Box/Violin plots of diversity indices across Healthy vs. Disease, stratified by antibiotic use and treatments.
Stacked bar plots of the top 10–15 most abundant taxa in Healthy vs. Disease groups.
Longitudinal plots if repeated samples exist (e.g., pre- vs. post-antibiotic use).
Feature importance plots (from SHAP/LASSO/XGBoost).
Stability plots: taxa selection frequency across CV/bootstraps.
Differential abundance plots (ANCOM-BC/DESeq2 results).


## Test Plan
Withhold 20% of labeled data as a fixed test set.
Train models on the remaining 80% using 5-fold cross-validation.
Evaluate with Accuracy, Precision, Recall, F1-score, and ROC-AUC.
Account for class imbalance using balanced accuracy, PR-AUC, or class-weighted models.
Compare diversity-based vs. taxa-based approaches.


