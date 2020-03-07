---
title: Readable R code
author: Yujun Zhou
date: '2018-09-23'
slug: r-code
categories:
  - Management
tags:
  - Project Management
  - Coding
---


In my [previous post](https://yujun-zhou.org/post/project/), I talked about managing projects with Github and how crucial it is to make your work reproducible. While we craft our writings on paper to present the idea better, it is equally important to make our code readable for someone trying to understand the work. 

I listed here a few points on writing more explicit code, mostly from my own experience. Read more about good and bad R code style on [Google's R Style Guide](https://google.github.io/styleguide/Rguide.xml). 


### Start writing and keep refining your code

When you just started to learn how to write code in R, don't worry about any code style and just start writing. Before long, you will find that you are doing repeated work that can be replaced by some simple loops. Basically, if you can do it with copy and paste, you can use a loop! There are lots of guides online on how to write loops, but the easiest way is to start with a small n and figure it out gradually. 

As you develop your project further, you will find that you use some code chunks repeatedly with a slight variation. Then it would be a good idea to start writing your own functions that can be reused across analyses and projects. 

### Separate functions from scripts 

  - functions are for specific purposes and can be used elsewhere
  
  Below is a simple function that I wrote for generating long date and yearmon formatted dates from a data frame with variables "year" and "month". 

  ![Function](function.png)
  
  - Scripts are used to generate graphs and tables and save them as intermediate products
  
  longer, makes of functions. 

  ![ScritpS](script.png)

  - Make the body of the scripts more readable 



 
### Keep scripts to a minimum
 
To avoid the hassle of writing a step-by-step readme document to inform the readers, you need to keep the number of scripts to a minimum. Perhaps 1. a cleaning script 2. exploratory data analysis 3. models  4. a script that generates all the formatted tables and graphs. 
 
 
### Code comments

  * Comment at the top about the purpose of the code, input, and output 
  
  * Use packages and source functions at the start
  
  * Make comments on each step 
  
  * Use meaningful variable or function names
  

### Use dplyr and piping

  dplyr is my go-to package for managing data frame. Its underlying C++ code makes running your daily data processing faster than other packages. 
  
  What's more, the "piping" grammar provided by the dplyr package makes a series of processing steps on a data frame much more concise. You can leave out the name of the data frame after the piping sign "%>%." 
  
  
  Example: list the median size of each type (at least 3), in decreasing order 
    
    ```
    data_frame %>% group_by(type) %>%
    
      summarise(median_size = median(size, na.rm = TRUE)) %>%
      
      filter(median_size > 3) %>%
      
      arrange(desc(median_size)) %>%
      
      select(type, median_size)
    ```

