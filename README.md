<h1> Machine Learning Project: Natural language processing (NLP) | Recipes Recommender </h1>

In this project, I built a model that can recommend vegan and vegetarian recipes to the user, based on an input (an omnivore or vegetarian recipe that he/she likes). 
The model was built using Natural Language Processing (NLP): CountVectorizer and Cosine_similarity

<a href="https://docs.google.com/presentation/d/1vpxj7OO5VGmPUT034vFvNGbNX_wOA1jYvpKQ4Emhkt0/edit?usp=sharing"> Project Presentation </a>

<h2> ML Project Steps: </h2>
1 - First, the data was gathered using web scraping (Beautiful Soup and Selenium) and flat files from Kaggle.

2 - Secondly, the data was cleaned, processed, and added to a normalized MySQL Database

3 - Next, I processed the data for the model using Natural Language Toolkit (NLTK): word_tokenize, WordNetLemmatizer, stopwords.

4 - Finally, I built the recipes recommender that takes a recipe as input from the user and uses CountVectorizer to suggest a similar vegetarian or vegan recipe.
 

This final project also included : 
- collecting data from Big Query (Google Cloud) and from API
- building an API to expose the data collected using python (flask)


