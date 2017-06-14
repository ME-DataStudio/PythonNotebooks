import tweepy
from textblob import TextBlob

consumer_key = 'wcus1JNrEZvvjVJidl3MbdFkh'
consumer_secret = 'NSupc6MvsmBsDgQVtBuEvg0rxk5BgG8WkpVMD4WPjZFCmdpV2'

access_token = '103939924-g1idfXSYAePjixCTM1WQiUYnptqzJvE2M2qjX5Lj'
access_token_secret = 'avfySWOmoyEK5aukZaIuuNA73RMd6Wrcf0R3fDpwLcl1y'

auth = tweepy.OAuthHandler(consumer_key,consumer_secret)
auth.set_access_token(access_token,access_token_secret)

api = tweepy.API(auth)

public_tweets = api.search('Trump')

for tweet in public_tweets:
    print(tweet.text)
    analysis = TextBlob(tweet.text)
    print(analysis.sentiment)