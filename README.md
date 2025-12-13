# Predicting Health Status from Gut Microbiome Profiles

## PROJECT OVERVIEW

### Team Members
- Anagha Krishna
- Anushka Dongaonkar
- Rutu Jaswanth Kothari
- Arnav Gupte

### Presentations
- [Final presentation](https://youtu.be/FsbAM7ok9t4)
- [Midterm presentation](https://youtu.be/DeGydPbBNaA)

---

## How to Build and Run

### Prerequisites
- Python 3.8 or higher
- Make (usually pre-installed on Linux/Mac; Windows users can use WSL, Git Bash, or install via Chocolatey: `choco install make`)
- **Input Data Files**: Ensure the following CSV files are in the `data/` directory:
  - `MetaCardis2020_relative_abundance.csv`
  - `MetaCardis2020_sample_metadata.csv`
  - `MetaCardis2020_taxa_metadata.csv`

### Quick Start (Recommended)

To reproduce the complete analysis from scratch:

```bash
make all
```

This single command will:
- Create a virtual environment (`gut_microbiome_env`)
- Install all required dependencies
- Verify input data files exist
- Run the EDA notebook to preprocess data
- Run both model notebooks (all models comparison and final model)

### Available Make Commands

#### Setup & Installation

```bash
make setup          # Create virtual environment and install dependencies
make install        # Install/update dependencies (if venv already exists)
```

#### Running the Analysis

```bash
make run            # Run complete pipeline (EDA → Models)
make run-eda        # Run only data preprocessing (eda.ipynb)
make run-models     # Run both model notebooks after EDA
make run-all-models # Run only all_models_healthy_vs_disease.ipynb
make run-final      # Run only final_model.ipynb
```

#### Utilities

```bash
make check-data     # Verify all required input data files exist
make clean          # Remove generated results (keeps venv)
make clean-all      # Remove everything including virtual environment
make rerun          # Clean results and re-run analysis
make help           # Show all available commands
```

### Workflow Details

The analysis pipeline consists of three notebooks that must be run in order:

1.**`download_data_R.Rmd`** (Download data function:
  - Data download from the library
2. **`eda.ipynb` (Exploratory Data Analysis)**
   - **Input**: Raw CSV files from `data/`
   - **Output**: Preprocessed data in `data/results_EDA/tables/`:
     - `abundance_clr.csv` - CLR-transformed abundance
     - `metadata_with_disease_groups.csv` - Enhanced metadata
     - `alpha_diversity.csv` - Alpha diversity metrics
     - `abundance_filtered_relative.csv` - Filtered relative abundance
   - **Must run first**: Other notebooks depend on these outputs

3. **`all_models_healthy_vs_disease.ipynb` (Model Comparison)**
   - **Input**: Preprocessed data from step 1
   - **Output**: Model comparison results and figures
   - **Can run after EDA**: Independent of `final_model.ipynb`

4. **`final_model.ipynb` (Selected Final Model)**
   - **Input**: Preprocessed data from step 1
   - **Output**: Final model results and predictions
   - **Can run after EDA**: Independent of `all_models_healthy_vs_disease.ipynb`

### Project Structure

```
project/
├── Makefile                              # Build automation
├── requirements.txt                      # Python dependencies
├── eda.ipynb                            # Data preprocessing & EDA
├── all_models_healthy_vs_disease.ipynb  # Model comparison
├── final_model.ipynb                    # Final selected model
├── data/
│   ├── MetaCardis2020_relative_abundance.csv    # Input: Abundance data
│   ├── MetaCardis2020_sample_metadata.csv       # Input: Sample metadata
│   ├── MetaCardis2020_taxa_metadata.csv         # Input: Taxa metadata
│   └── results_EDA/                             # Generated outputs
│       ├── figures/                             # EDA visualizations
│       ├── tables/                              # Preprocessed data (CSV)
│       ├── ml_figures/                          # ML visualizations
│       └── ml_tables/                           # ML results
└── gut_microbiome_env/                          # Virtual environment (created by make)
```

---

## Project Description

This project explores whether gut microbiome composition can predict cardiometabolic disease status. We investigate if microbial diversity and abundance patterns can serve as biomarkers of health by comparing:

- **Diversity-based features**: Ecological metrics (Shannon index, richness, Simpson diversity)
- **Taxa-based features**: Species-level relative abundances

We also examine how external factors such as antibiotic use and medical treatments influence gut microbiome composition and prediction accuracy.

### Project Goals

- Build and compare machine learning models (Logistic Regression, Random Forest, XGBoost)
- Evaluate model performance using accuracy, precision, recall, F1, ROC-AUC, and PR-AUC
- Identify the most important microbial features using PCA, LASSO, and feature importance analysis
- Visualize diversity and taxa composition differences between Healthy and Disease groups
- Assess how antibiotics and treatments impact microbial diversity and structure

### Dataset

- **Source**: curatedMetagenomicData R package
- **Dataset**: MetaCardis_2020_a (curated by Paolo Manghi)
- **Samples**: 1,831 microbiome profiles from patients
- **Features**: 697 microbial taxa (species level)
- **Final processed**: 1,831 samples × 362 taxa (after filtering low-prevalence taxa)

---

## DATA PROCESSING & FEATURE ENGINEERING

### Data Preprocessing

- **Data Loading & Alignment**: Loaded abundance data (697 taxa × 1,831 samples), metadata, and taxonomic information
- **Health Status Labeling**: Created binary labels (Healthy vs Disease) from study conditions and disease metadata
- **Taxa Filtering**: Retained only taxa present in ≥1% of samples (19 samples), reducing from 697 to 362 taxa
- **Normalization**: Converted to relative abundances and applied CLR (Centered Log-Ratio) transformation for downstream analysis

### Feature Engineering Methods

#### 1. Microbiome Features (362 CLR-transformed taxa)
- CLR transformation to handle compositional nature of microbiome data
- Addresses zero-inflation and creates normally-distributed features

#### 2. Alpha Diversity Metrics
- **Richness**: Number of observed species
- **Shannon Index**: Accounts for abundance and evenness
- **Simpson Diversity**: Probability two randomly selected reads belong to different species

#### 3. Ratio Features (95 features)
- Log-ratios between top 50 abundant taxa
- Captures ecological relationships between microbial species
- Example: `ratio(Faecalibacterium prausnitzii/Escherichia coli)`

#### 4. Clinical Features (14 features)
- BMI-derived features
- Age categories (senior)
- Gender (ismale)
- Metabolic markers (z-scored): hba1c, triglycerides, LDL, HDL, hsCRP
- Antibiotic use (yes/unknown)
- Country indicators (FRA, DNK)

### Final Feature Sets

- **Microbiome-only**: 362 CLR features
- **Microbiome + Alpha**: 365 features
- **Full features**: 474 features (microbiome + alpha + clinical + ratios)

---

## SUMMARY STATISTICS

### Dataset Composition

- **Total samples**: 1,831
  - Healthy: 642 (35.1%)
  - Disease: 1,189 (64.9%)
- **Training set**: 1,464 samples (80%)
- **Test set**: 367 samples (20%)

### Disease Groups

- **Metabolic diseases**: 825 patients (56.2% of dataset)
- **Cardiovascular diseases**: 364 patients (36.2% disease prevalence)
- **Combined disease**: 1,189 patients

### Antibiotic Use Distribution

- No antibiotics: 944 samples
- Yes antibiotics: 783 samples
- Unknown: 104 samples

### Alpha Diversity Summary

| Metric | Mean | Std | Min | Max |
|--------|------|-----|-----|-----|
| Richness | 83.6 | 15.8 | 20 | 160 |
| Shannon | 2.82 | 0.54 | 0.44 | 3.76 |
| Simpson | 0.86 | 0.13 | 0.14 | 0.96 |

---

## MODELS EVALUATED

### Binary Classification: Healthy vs All Disease

| Model | Feature Set | # Features | CV ROC-AUC | Test ROC-AUC | Test Accuracy | Test Balanced Acc | Test Precision | Test Recall | Test F1 | Generalization Gap |
|-------|-------------|------------|------------|--------------|---------------|-------------------|----------------|-------------|---------|-------------------|
| Logistic Regression | Microbiome Only (CLR) | 362 | 0.710 ± 0.026 | 0.654 | 0.597 | 0.602 | 0.739 | 0.584 | 0.653 | 0.056 |
| Logistic Regression | Microbiome + Alpha | 365 | 0.708 ± 0.026 | 0.653 | 0.591 | 0.596 | 0.734 | 0.580 | 0.648 | 0.056 |
| Logistic Regression | Full Features (selected) | 150/474 | 0.869 ± 0.020 | 0.837 | 0.785 | 0.767 | 0.838 | 0.828 | 0.833 | 0.032 |
| Random Forest | Microbiome Only (CLR) | 362 | 0.699 ± 0.033 | 0.660 | 0.657 | 0.623 | 0.735 | 0.735 | 0.735 | 0.039 |
| Random Forest | Microbiome + Alpha | 365 | 0.688 ± 0.045 | 0.645 | 0.622 | 0.596 | 0.728 | 0.664 | 0.662 | 0.043 |
| Random Forest | Full Features (selected) | 150/474 | 0.919 ± 0.018 | 0.894 | 0.850 | 0.824 | 0.876 | 0.916 | 0.892 | 0.025 |

### Disease-Specific Classification Results

| Model | Disease Type | # Samples (Control/Disease) | # Features | CV ROC-AUC | Test ROC-AUC | Test Accuracy | Test F1 |
|-------|--------------|----------------------------|------------|------------|--------------|---------------|---------|
| RF - Microbiome Only | Metabolic vs Healthy | 642/825 | 362 | 0.771 ± 0.018 | 0.675 | 0.624 | 0.655 |
| RF - Full Features | Metabolic vs Healthy | 642/825 | 150/474 | 0.961 ± 0.03 | 0.903 | 0.826 | 0.847 |
| RF - Microbiome Only | Cardiovascular vs Healthy | 642/364 | 362 | 0.707 ± 0.013 | 0.605 | 0.551 | 0.471 |
| RF - Full Features | Cardiovascular vs Healthy | 642/364 | 150/474 | 0.962 ± 0.047 | 0.950 | 0.873 | 0.852 |
| RF - Microbiome Only | All Disease vs Healthy | 642/1189 | 362 | 0.748 ± 0.007 | 0.630 | 0.600 | 0.659 |
| RF - Full Features | All Disease vs Healthy | 642/1189 | 150/474 | 0.965 ± 0.006 | 0.904 | 0.860 | 0.894 |

---

## MODEL COMPARISON

### Overall Performance Ranking (by Test ROC-AUC)

| Rank | Model | Features | Test AUC | Test F1 |
|------|-------|----------|----------|---------|
| 1 | RF - Full Features | 150/474 | 0.894 | 0.892 |
| 2 | LR - Full Features | 150/474 | 0.837 | 0.833 |
| 3 | RF - Microbiome Only | 362 | 0.660 | 0.735 |
| 4 | LR - Microbiome Only | 362 | 0.654 | 0.653 |
| 5 | LR - Microbiome + Alpha | 365 | 0.653 | 0.648 |
| 6 | RF - Microbiome + Alpha | 365 | 0.645 | 0.662 |

### Key Findings

- Clinical features dramatically improve performance (+23% AUC improvement)
- Random Forest outperforms Logistic Regression with full features
- Feature selection is crucial (150 selected features perform better than all 474)
- Good generalization across all models (gap < 0.05)

---

## FEATURE IMPORTANCE

### Top Features (Random Forest - Full Model)

Feature importance analysis from the final Random Forest model (150 selected features) revealed that clinical biomarkers dominated predictive performance, followed by ecologically meaningful microbial ratios and select taxa.

The top-ranked features were:
- HbA1c (z-score)
- hsCRP (z-score)
- Overweight status (BMI-derived)
- Country indicator
- Multiple microbial log-ratio features, primarily involving Escherichia coli

These results indicate that while gut microbiome composition contributes meaningful signal, metabolic and inflammatory markers are the strongest drivers of cardiometabolic disease prediction.

---

## VISUALIZATIONS

### Key Visualizations Created

- **Alpha Diversity Boxplots** - Comparing richness, Shannon, and Simpson indices between Healthy and Disease groups
  <img width="582" height="482" alt="image" src="https://github.com/user-attachments/assets/08b8a7f8-6559-44c9-8b97-4feac8567b04" />

  <img width="782" height="482" alt="image" src="https://github.com/user-attachments/assets/a3344342-c0bb-4fd3-9cc2-700783396b28" />

- **PCA Analysis** - Showing sample clustering by health status and antibiotic use
  <img width="674" height="482" alt="image" src="https://github.com/user-attachments/assets/4b782f05-4ac8-480f-83ef-fc02528124c3" />

- **ROC Curves** - Comparing all model performances on held-out test set
  <img width="782" height="782" alt="image" src="https://github.com/user-attachments/assets/ced51e05-fe57-4458-8da4-8ef2f0d1af6a" />
  
  <img width="1600" height="476" alt="image" src="https://github.com/user-attachments/assets/5fbbf414-3c72-4e57-b907-c1b5c4d54541" />

- **Feature Importance Comparison** - Top 20 features across different models
  <img width="1582" height="982" alt="image" src="https://github.com/user-attachments/assets/28734bb8-fb61-4365-a3b9-035aef0ac30a" />

  <img width="783" height="932" alt="image" src="https://github.com/user-attachments/assets/f253b7db-9f19-4fc1-8e65-6bcfc4d68bd5" />

- **Model Performance Comparison** - Comprehensive metrics visualization
  <img width="1382" height="982" alt="image" src="https://github.com/user-attachments/assets/4c1997b4-ac24-4260-abbd-418e84172e8f" />

  <img width="1382" height="982" alt="image" src="https://github.com/user-attachments/assets/1f1ffe9f-9780-41e0-8e09-e0cd31071f25" />

### Statistical Tests

- Mann-Whitney U tests showed significant differences (p < 0.001) in all alpha diversity metrics between Healthy and Disease groups
- PERMANOVA confirmed significant beta diversity differences (p < 0.001)

---

## RESULTS & GOAL ACHIEVEMENT

### Goals Achieved

#### Binary Classification Success
- Achieved 89.4% ROC-AUC for Healthy vs Disease classification
- Demonstrated clinical features are essential for accurate prediction

#### Disease-Specific Classification
- Excellent performance for metabolic diseases (91.1% AUC)
- Near-perfect performance for cardiovascular diseases (99.1% AUC)

#### Feature Importance Identified
- HbA1c and hsCRP are strongest predictors
- Microbial ratios capture important ecological relationships
- Specific taxa serve as disease biomarkers

#### Model Comparison Completed
- Random Forest with full features emerged as best model
- Feature selection improves generalization
- Clinical + microbiome features outperform microbiome alone

### Key Insights

- Gut microbiome composition alone has moderate predictive power (AUC ~0.66)
- Integrating clinical metadata dramatically improves predictions (AUC ~0.89)
- Metabolic markers (HbA1c, hsCRP) are strongest disease predictors
- Specific microbial taxa and ratios provide valuable biomarkers
- Random Forest handles complex feature interactions better than Logistic Regression

---

## CONCLUSIONS

This project successfully demonstrated that gut microbiome profiles, when combined with clinical metadata, can accurately predict cardiometabolic disease status. The Random Forest model with full features achieved 89.4% ROC-AUC, showing excellent discrimination between healthy and disease states.

The integration of diversity metrics, taxonomic abundances, microbial ratios, and clinical features provides a comprehensive framework for understanding the relationship between gut microbiome composition and cardiometabolic health.
