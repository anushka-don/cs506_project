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
The gut microbiome has been known to play a major role in influencing human health. However, an important question remains — can the composition of these microbes help us understand a person’s health status?  

That is the main goal of our project. We are analyzing gut microbiome data from 1,800 patients with different health conditions, including impaired glucose tolerance (IGT), heart failure (HF), coronary artery disease (CAD), type 2 diabetes (T2D), and a healthy control group. Using relative abundance data from about 600 microbial species, we aim to identify which microbes differ significantly across disease conditions and could serve as potential indicators of health or disease.  

We began by cleaning the dataset. Microbes with more than 1% missing values were removed to maintain data quality. Overall, the dataset was fairly clean and required minimal preprocessing.  

Next, we calculated both alpha and beta diversity to understand the microbial variation within and between samples.   
1. Alpha diversity measures how diverse the microbial community is within a single sample.
2. Beta diversity compares the microbial composition between different samples or groups.

We visualized these results to compare the diversity across different disease conditions. 

We then performed clustering based on microbial composition to see if patients naturally grouped according to their health condition. However, no clear or well-separated clusters were observed. This suggests that while disease conditions may influence microbial abundance, the overall microbial structure is quite complex and overlapping among groups.   

Our next goal is to identify the specific microbial populations that differ across health conditions. This will involve feature selection and feature engineering to pinpoint which microbes have the most influence.  

So far, we have identified several microbes showing significant differences in relative abundance between disease groups using the Mann–Whitney (MW) test and other statistical approaches. These findings will help guide our next phase of analysis and model development.  



