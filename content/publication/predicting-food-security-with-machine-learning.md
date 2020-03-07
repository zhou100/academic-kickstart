---
title: Predicting Food Security with Machine Learning
author: Yujun
date: "2019-12-12"
slug: predicting-food-security-with-machine-learning
categories: []
tags: []

# Authors. Comma separated list, e.g. `["Bob Smith", "David Jones"]`.
authors: ["**Yujun Zhou**","Kathy Baylis","Erin Lentz", "Hope Michelson"]


# Publication type.
# Legend:
# 0 : Uncategorized
# 1 : Conference proceedings
# 2 : Journal
# 3 : Work in progress
# 4 : Technical report
# 5 : Book
# 6 : Book chapter
publication_types : ["3"]

# Abstract and optional shortened version.

abstract: Hunger is on the rise throughout Africa, with famine threatening millions across several countries. Rapid and accurate identification of food insecurity crises can enable humanitarian responses to mitigate casualties from hunger and save lives. We develop a predictive model of food security based on readily available, spatially granular data on prices, geography, and demographics. Using machine learning techniques, we are able to improve the accuracy of predicting those villages that face a potential threat of hunger. As with any rare event, one challenge with predicting food insecurity is the low rate of severe food insecurity in the baseline data.  We use several different approaches to address this imbalance to allow us to capture a higher fraction of these rare events.  We apply our procedure to three sub-Saharan African
countries: Malawi, Tanzania, and Uganda to predict food security in out-of-sample villages. Bearing in mind the possible spatial-temporal correlations between observations in the training and testing set, we use a nested cross-validation method on year-split data to get a more robust result.  We correctly identify up to 40 percent of the most food-insecure clusters, when the baseline model using a logistic regression did not detect any of them.  Our result shows that a data-driven model with the help of machine learning methods can significantly improve its performance on capturing the food insecure households despite the imbalance in the data.  Our paper demonstrates that this approach could be used in a scalable, automatically updated prediction model that could enhance the current famine early warning systems.

# abstract_short : "A short version of the abstract."

# Featured image thumbnail (optional)
image_preview : ""

# Is this a selected publication? (true/false)
selected : true

# Projects (optional).
#   Associate this publication with one or more of your projects.
#   Simply enter the filename (excluding '.md') of your project file in `content/project/`.
#   E.g. `projects : ["deep-learning"]` references `content/project/deep-learning.md`.
projects : ["food-security"]

# Links (optional).
url_pdf : ""
url_preprint : ""
url_code : ""
url_dataset : ""
url_project : ""
url_slides : ""
url_video : ""
url_poster : ""
url_source : ""

# Custom links (optional).
#   Uncomment line below to enable. For multiple links, use the form `[{...}, {...}, {...}]`.

# Does the content use math formatting?
math : true
featured : true

# Does the content use source code highlighting?
highlight : true

# Featured image
---
