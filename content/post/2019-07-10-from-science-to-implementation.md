---
title: 'From Science to Implementation'
author: Yujun Zhou
date: '2019-07-10'
slug: from-science-to-implementation
categories: []
tags: []
---

During my summer internship, I closely observed how scientific models are combined with real-time data to generate tailored information for each farm to guide daily agricultural operations. I realize one big difference between the data science in industry settings and the work that we do in academics, is how this company's science does not stop at the point when the model was proved to be working. Instead, the model is continuously being validated, updated, and improved for better performance in daily operations when new data or tools are coming in.

The implementation of a dynamic data science product, in some cases, can significantly improve the value provided by the science at its core. The benefit of a dynamic process over a static, one-off model include the following: 

1. The information is close to real-time, as in this month, today or even this very minute (e.g., traffic jams info, Uber ETA).
    
2. Model is monitored, modified frequently, so it's robust to changes (structural or seasonal) in data patterns. 
    
3. The process is automated, replicable, optimized, and efficient.
  
The science behind the model is the core of delivering accurate estimates and relevant recommendations. Equally important is the data engineering work that puts the science to work. However, it can be tough and challenging to build, especially in academic research settings when most of the team are scientists, instead of engineers. Let's take a look at what the process looks like and what it takes to build it. 

A typical workflow of a data science product looks like this:

![Work Flow](workflow.png)

First, automatically or manually collected data enters the process, in the form of unstructured or nested files stored on an Amazon S3 buckets (or on Qualtrics, or a hard drive). Through carefully designed data pipelines, they become tables of variables that can feed directly into the primary model. The model can be predictive (e.g., machine learning models), or simulation (parameterized theoretical models), or causal (if data is experimental). Then, there is training, testing, validation, parameter tuning involved, to make sure that the model performs well. When the best model is selected, data output and visualization scripts take a subset of the model outputs to generate daily reports, recommendations, APIs to maps/graphs that are readable to users on their phone apps, webpages, newsletters. Validation scripts calibrate parameters from time to time, using ground truth data or user feedback.  

The challenges of implementing this process in academic settings are multiple. Here is a brief list that I can think of: 

1. Available data and data quality. Usually, we don't get frequently updated data like the firms do in their operations. Survey data are typically conducted once a year for a few years, and there are data quality issues involved in terms of missing data, attrition, and administrative errors.
    
2. Building the data flow. Even if we have enough quality data available and that they are updated frequently, building the flow requires a lot of the data engineering skillsets. Platforms such as the Amazon SageMaker maybe the solution in the future, but learning about the tools and tailoring them to your needs still require much work. 
    
3. Scale and flexibility. Storing and processing data is costly, even with the help of cloud computing. Handling large data sometimes can mean a complete rewrite of the entire flow, which makes it hard for the process to scale. For example, if the data is too large to read into the memory, distributed data systems such as Spark are needed. In Spark, both the data structure and the syntax are different, and the available tools in the Spark setting are limited, compared to a local machine notebook.

All of this leaves us the questions: what kind of problems can benefit the most by building such an automated process? Are the data updated frequently with enough variation and somewhat good quality? Do we have the team with the skillset to build and maintain the process? Does the benefit outweigh the cost involved? 

Here are some potential applications using frequently updated and accessible data: futures prices and stock prices, satellite imageries (NDVI, weather), market prices, electricity/energy usage, and water level.  In our food security prediction settings, prediction of the weekly updated market prices using local weather patterns and satellite imageries may be a close target to have. If the model predicts sudden, drastic changes in market prices based on information, this might be a signal towards a potential food security alarm in real time. 

