---
title: "Experience about how to make Jekyll Github Pages appear on Google search result"
date: 2020-03-04 14:44:00 +0800
categories: [Learning, Self-study]
tags: [Google search Console, GitHub Pages, Jekyll, Gem]
---

>From [Victor's Playground](https://victor2code.github.io/blog/2019/07/04/jekyll-github-pages-appear-on-Google.html)


There is no point to make a website if it cannot be indexed on Google, so lets take a look at how to make your site and pages appear on Google search result.

## Google search console


You need to use this system provided by Google to accomplish this task. Simply log in to this [**system**](https://search.google.com/search-console/about) with your Google account, and click `Start now`.


## Owner verification


The first step is to let Google know you are the owner of a site, which is identified as a property here. Obviously, you can have a lot of properties.


* Select `Domain` or `URL prefix` as your property type, and input your website address, e.g. `https://huadous.com`

![select_property_type]({{ "/assets/img/sample/select_property_type.png" | relative_url }})

    The address you put here should be the root folder of your website, which is the place your  `index.html` resides. If you have multiple sites under your github pages, you can register one property for each of them.
    
    
     The address you put here should be the root folder of your website, which is the place your  `index.html` resides. If you have multiple sites under your github pages, you can register one property for each of them.


* Choose one of the method the websites provides to do the verification. 
  
  
1. If you have chose `URL prefix` , the first option would be the easiest way to do that. All you need to do is to download an html file and upload to your website root folder. But unforunately I tried many times to do the uploading, google failed to identify the file, even though I can access it via url. 
   
   So I use the second option to accomplish the verification. The goal is to add an html tag to your homepage `<head>` tag. Below steps apply to minima theme.
   
     - Copy `_includes/head.html` from github to your website if it is not there.
     - Edit `head.html` to add the tag provided by google by google in between the `<head>` tag like below.
       


     - Click `verify` button, and you are done with it. It may take few minutes for the meta data to take effect, so be a little patient.
    
    ![verify_success]({{"/assets/img/sample/verify_success.png" | relative_url}})

     - It may take hours to few days until you can see the performance about your website in the console.



  1. If you have chose `Domain`, you can do this: 


## Site Map

Okay, Google is aware of the existence of your website now. Next, you need to tell Google what your website hierarchy is, which is achieved by a file called [sitemap](https://github.com/jekyll/jekyll-sitemap).

**Sitemap** stores the structure of your site, like how many pages are there, and what is the url for each of them, something like that.

Github Pages can generate a site map automatically for your site, just simply follow this official instruction:

1. Add `gem 'jekyll-sitemap'` to your site's Gemfile and run `bundle`.

2. Add the following to your site's `_config.yml`:

    ```html
    url: "https://example.com" # the base hostname & protocol for your site
    plugins:
        - jekyll-sitemap
    ```

3. a file named `sitemap.xml` will generate automatically at the root folder of your site, such as `https://huadous.com/sitemap.xml` for this site. You shall be able to check it out via this url in browser

     Then, you can submit the address of your sitemap file to Google Search Engine, prompting the Googlebot to analyze your site for indexing.

     For my case, I could not search my site via site name until **2 days** after I submit the sitemap file. And it is **5 dyas** for posts to be searchable via title name. It takes some patience.


# URL Inspection

Yes! If everything goes smoothly, you site can be found via Google now, that is exciting.

But even you have submitted your sitemap to Google, certain pages just can not be indexed on Google search result. You can submit the url of the page to this URL Inspection tool, and Google will show you why your page can not be indexed, and how to solve the problem.

Follow the tips from Google and you shall be all covered.
