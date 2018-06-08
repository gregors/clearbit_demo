# Clearbit Demo 

...

# Development

## Getting Started

### Requirements

To run the specs or fire up the server, be sure you have these installed (and running):

* Ruby 2.4 (see [.ruby-version](.ruby-version)).
* Heroku CLI (`brew install heroku`).

### First Time Setup

After cloning, run:
    $ bundle install 

#### `.env`

There is a `.env.sample` file that defines settings for your local environment. Enter appropriate values and rename to `.env`. Do not check this into source control. Refer to the [environment variables](#environment-variables) section below for what can be specified in `.env`.

### Running the Specs

    $ rake 

### Running the Application Locally

The easiest way to run the app is using `heroku local`. This starts all the processes defined in `Procfile`, including the Rails server.

    $ heroku local
    $ open http://localhost:5000

## Conventions

### Git

* Branch `development` is auto-deployed to acceptance.
* Branch `master` is auto-deployed to production.
* Create feature branches off of `development` using the naming convention
  `(features|chores|bugs)/a-brief-description-######`, where ###### is the tracker id.
* Rebase your feature branch before merging into `development` to produce clean/compact merge bubbles.
* Always retain merge commits when merging into `development` (e.g. `git merge --no-ff branchname`).
* Use `git merge development` (fast-forward, no merge commit) from `master`.
* Craft atomic commits that make sense on their own and can be easily cherry-picked or reverted if necessary.

### Code Style

Rubocop is configured to enforce the style guide for this project.

## Additional/Optional Development Details

### Code Coverage (local)

Coverage for the ruby specs:

    $ COVERAGE=true rspec
    $ open coverage/index.html

### Continuous Integration/Deployment with CircleCI and Heroku

This project is configured for continuous integration with CircleCI, see [circle.yml](circle.yml) for details.

On successful builds, Heroku will trigger a deployment via its
[GitHub Integration](https://devcenter.heroku.com/articles/github-integration#automatic-deploys).

# Server Environments

### Hosting

Production is hosted on Heroku.

### Environment Variables

Several common features and operational parameters can be set using environment variables.

**Required**

* `PLAID_CLIENT_ID` - Plaid client id
* `PLAID_SECRET` - Secret key for Plaid access
* `PLAID_PUBLIC_KEY` - Plaid public key
* `PLAID_ENV` - Paid environment set to sandbox by default
* `CLEARBIT_KEY` - Clearbit API key 
* `SESSION_SECRET` - Secret key base for verifying signed cookies. Should be 30+ random characters and secret!
* `PORT` - Port to listen on (default: 5000).

**Optional**

* `HOSTNAME` - Canonical hostname for this application. Other incoming requests will be redirected to this hostname.
* `RACK_TIMEOUT_SERVICE_TIMEOUT` - Terminate requests that take longer than this time (default: 15s). 

### Third Party Services

* Heroku for hosting.
* CircleCI for continuous integration.
