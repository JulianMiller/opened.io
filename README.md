Opened.io 
==========

An emberjs application for [opened.io](http://opened.io/). 

How to get started
------------------
0. Install RVM and Ruby (See https://rvm.io/rvm/install), install compass and sass with `gem install compass`.
1. Make sure you have nodejs installed at your system, you can check it by running a comand: `node -v`. If you get an error, check [nodejs install guide](http://nodejs.org/)
2. Then you need to install packages for nodejs with `sudo npm install -g yo grunt-cli bower karma karma-spec-reporter`, it will install [yeoman](http://yeoman.io/), [gruntjs](http://gruntjs.com/), [bower](http://bower.io/), and karma test runner
3. Clone the repository with `git clone git@github.com:openedinc/opened.io.git`
4. `cd` to opened-web cloned directory
5. Install nodejs packages specific for this project by `npm install`
7. If everything is went okay, you should be able to type `grunt server` (shortcut for `grunt server --env=dev`) and go to [0.0.0.0:9000](http://0.0.0.0:9000) to see the application
8. Use `grunt server --force` if you want the server to keep running after SASS or coffeScript errors
9. Use --env flag to specify which config you want to run at your local server, for instance `grunt server --env=dev-local` will use dev-local.json and pick a localhost as the API server.

N.B. If you have troubles with compass, like "/Gemfile not found (Bundler::GemfileNotFound)",  try `gem uninstall rubygems-bundler`

Test Framework
--------------

Test framework lives under /test directory. We are using [qUnit](http://qunitjs.com/) as a testing framework

Karma is our test runner, it allows to run test in many browsers/environments at the same time, and provides
integration with Travis CI

`karma start`

if you don't have a Firefox browser you can run 

`karma start --browsers Chrome`


How to deploy to Heroku
-----------------------

In order to deploy to staging just run `grunt deploy`, wich is the shortcut for `grunt deploy --env=staging`.

Use flag --env to deploy to other environments, you can find corresponding configs in the configs folder.

`grunt deploy --env=prod` will deploy the code on production environment.
Feel free to add configs to your own heroku applications, but do not check them into github.

Use flag --msg to specify a deployment message






