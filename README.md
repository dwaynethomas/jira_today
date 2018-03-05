# jira_today - a project to practice TDD against apis
# https://github.com/sumoheavy/jira-ruby

As a user, one wants to know how many Jira issues as a user have edited today so that I can share that information with my teammates.


Test will verify that we are grabbing the right information.
-test if program loads jira-ruby
-test verify connected to jira with parameters(not credentials)
-test verify results from jira
-test verify results that a user edited
-test verify results based on the date that a user has edited

Instructions for use:

gem install pry
gem install jira-ruby

rvm use 2.3.1@jira_today
rvm current

binding.pry
q  #stops reading in program
exit-program #stops program

next assignments:
practice asking what an object is?
research accessing dataobjects with arrays
research using program blocks

api results will be made into an object one can practice TDD against.