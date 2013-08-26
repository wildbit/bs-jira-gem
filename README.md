# JIRA

Yet another lightweight JIRA API Wrapper for Ruby.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'jira', :github => 'chrisledet/jira'
```

And then execute:

```shell
$ bundle install
```

## Example Usage

```ruby
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
client.add_comment_to_issue(issue_id , "It Just Works!")

# Add a label
client.add_label_to_issue(issue_id , "beta")
```

## Run Tests

```shell
$ bundle exec rake test
```
