---
title: An example manuscript file 
bibliography: bibliography.bib
fontsize: 10pt
csl: science.csl
figPrefix:
  - Figure
  - Figures
tblPrefix:
  - Table
  - Tables
---

*Peter C. St. John^1^*

^1^Biosciences Center, National Renewable Energy Laboratory, Golden CO 80401

# Introduction

A quick demo of writing a manuscript in markdown. More examples can be found from [pandoc-crossref](https://github.com/lierdakil/pandoc-crossref). A reference [@Atkins_2002], some equations ([@eq:equation]), and a figure ([@fig:testfig]).

$$f(x) = x^2$$ {#eq:equation}

![**A test figure title.** Additional descriptions.](figs/svg-renderer-test){#fig:testfig}

# References
