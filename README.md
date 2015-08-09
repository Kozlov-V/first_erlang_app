firstapp
=====

An OTP application

Build
-----

    $ rebar3 compile


Deploy on Heroku
----------------

```
heroku create firstapperlang --stack cedar-14 --region eu --buildpack "https://github.com/heroku/heroku-buildpack-erlang.git"
 Creating firstapperlang... done, region is eu
 Buildpack set. Next release on firstapperlang will use https://github.com/heroku/heroku-buildpack-erlang.git.
 https://firstapperlang.herokuapp.com/ | https://git.heroku.com/firstapperlang.git
 Git remote heroku added
```
