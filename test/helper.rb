require 'bundler'
require 'test/unit'
require 'turn'
require 'yaml'
require 'jira'


class JiraTestCase < Test::Unit::TestCase
  def config
    @config ||= YAML::load(File.open("test/config.yml"))["jira"]
  end
end
