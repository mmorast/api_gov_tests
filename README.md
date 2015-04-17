# api_gov_tests

This repository contains tests of the api.data.gov RESTful APIs for Alternate Fuel Stations

Pre-requisites:
- curl installed
- git installed
- bash or zsh shell available

Assumptions:
- The nearest station request returns a default twenty results, and allows a larger batch to be requested or offsets given to get all entries (n of m). The test assumes that the desired station comes back in first batch instead of checking for station being returned and making further batch requests until number of stations are exhausted. 
- The tests assume the data we are testing is known and deterministic. Such as the ID is not changing between runs
- The tests also assume knowledge of JSON format. If this is variable or unknown then more logic would need to be in place to handle that.
 

##Steps to setup environment in Linux or OS X and run tests. Commands are all run and tested in bash and zsh.

1) Install Ruby. The instructions below are for RVM, but if you have your own Ruby then that can be used

    curl -sSL https://get.rvm.io | bash -s stable
    rvm install 2.1
    rvm use 2.1

2) Check if Bundler is installed. If bundler is not shown in results of the first command run the second

    gem list | grep bundler
    gem install bundler #if bundler was not present in previous command
    
3) Checkout tests

    cd <a directory of your choice to run these in>
    git clone https://github.com/mmorast/api_gov_tests
    
4) Run bundler to install gems
    
    bundle install
    
5) Run tests 

    ruby alt_fuel_station_test.rb
    
At this point the tests will have run and returned results
