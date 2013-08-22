require 'helper'

class JiraTest < JiraTestCase
  def setup
    @client = Jira::Client.new(config["url"], config["username"], config["password"])
  end

  def test_connection
    assert @client.connects?
  end

  def test_projects
    assert @client.projects
    refute @client.error_occurred?
  end

  def test_comments
    assert @client.comments("CLWA-73")
    refute @client.error_occurred?
  end

  def test_statuses
    assert @client.statuses
    refute @client.error_occurred?
  end

  def test_post_comment
    old_comments = @client.comments("CLWA-73")

    @client.post_comment("CLWA-73", "Posting a new comment")
    #refute @client.error_occurred?

    new_comments = @client.comments("CLWA-73")

    assert_equal(new_comments.size, old_comments.size + 1)
  end

  def test_update_issue_asignee
    assert @client.update_issue_assignee("CLWA-73", "chris")
  end
end
