# The Application

A flutter application that displays the top tech news stories using the Hacker News API.

This app focuses on performant data fetching as the API is structured in a way that requires a large
amount of requests to retrieve the required data.

- [Hacker News API](https://github.com/HackerNews/API)

## Performance Approach
In order to try improve the data fetching performance after initial launch, the app will use two sources of data.
When the app needs to fetch an item, it will first check a local cache to see if it has been fetched previously (Sqlite).
If not, it will fetch the item from the API and cache it locally.