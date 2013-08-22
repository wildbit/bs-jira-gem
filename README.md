# Jira

Internal JIRA client for Beanstalk. Because the current ones sucks!

## Installation

Add this line to your application's Gemfile:

    gem 'jira'

And then execute:

    $ bundle install

## Example Usage

    # Initialize a Jira Client
    client = Jira::Client.new("https://myjira.net/", "username", "lolsecure")

    # See if it connects
    if client.connects?
      puts "Woot. It works :)"
    end

    # Get all Projects
    projects = client.projects

    # Post a comment
    issue_id = "JIRA-123"
    client.post_comment(issue_id , "It Just Works!")

## Run Tests

    $ bundle exec rake test
