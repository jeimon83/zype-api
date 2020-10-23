Documentation for the Zype API is available here: ​ https://docs.zype.com/reference

Project
-
https://zypechallenge.herokuapp.com/

Install
-
Clone the repository

git clone https://github.com/jeimon83/zype-challenge.git

cd zypechallenge

Check your Ruby version

ruby -v

The ouput should start with something like ruby 2.7.1

If not, install the right ruby version using rbenv (it could take a while):

rbenv install 2.7.1
Install dependencies
Using Bundler and Yarn:

bundle && yarn
Set environment variables: ZYPE_APP_KEY, ZYPE_BASE_URL, ZYPE_CLIENT_ID, ZYPE_CLIENT_SECRET, ZYPE_LOGIN_URL, SIDEKIQ_USERNAME, SIDEKIQ_PASSWORD

Initialize the database
-
rails db:create db:migrate

Run scheduler
-
rake scheduler:fetch_videos_from_zype

Add heroku remotes
-
Using Heroku CLI
heroku https://git.heroku.com/zypechallenge.git --remote heroku

Serve
-
rails s & bundle exec sidekiq

Deploy
-
Directly to production (not recommended)
Push to Heroku production remote: git push heroku master

# ZYPE CHALLENGE - DEPLOYED IN HEROKU https://zypechallenge.herokuapp.com/

Ruby 2.7.1
Rails 6.0.3
PostgreSQL

High level architecture overview
-
Rails 6 app that retrieves videos from Zype API every hour using rake tasks and allows users to view content online.
Automate action for fetching videos from zype every one hour to improve user experience, some data of the videos is recorded, such as their id, title, thumbnail url, subscription and the path of the embedded player. Some videos require subscription, so API Consumer credentials are needed in order to view that content
In order to match the access token with the right consumer, the Zype access tokens persists through low level caching, and consumers emails persist with session[:email] variable.

Service Objects:
- 
Different services are created to connect to the Zype Api, so that all the videos can be listed for later recording in the database, as well as checking the right of a user to view certain content.

Client: app/services/zype/client
Videos: app/services/zype/videos
Consumer: app/services/zype/consumer
Oauth: app/services/zype/oauth

Zype Access Token:
-
Sometimes you need to cache a particular value or query result instead of caching view fragments. Rails' caching mechanism works great for storing any kind of information. In this case, the app supports multiple users while saving the zype access token using rails low level caching (read & write data to key-value store)

Models:
-
Videos -> Id, Title, Embed player Url, subscription, thumbnail

Third-party Gems:
-
**Dotenv-rails: load environment variables from .env into ENV in development

**Sidekiq: background jobs. in this case, for the Zype Video Fetcher Worke

**Bootstrap: css styles to improve front end UI

**Typhoeus: useful gem to make fast and reliable requests


