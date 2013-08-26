require 'helper'

class JiraTest < JiraTestCase
  def setup
    @client = Jira::Client.new(config["url"], config["username"], config["password"])
    @issue = config["issue_id"]
  end

  def test_connection
    assert @client.connects?
  end

  def test_projects
    assert @client.projects
    refute @client.error_occurred?
  end

  def test_comments
    assert @client.comments(@issue)
    refute @client.error_occurred?
  end

  def test_statuses
    assert @client.statuses
    refute @client.error_occurred?
  end

  def test_post_comment
    old_comments = @client.comments(@issue)
    @client.post_comment(@issue, "Posting a new comment")
    new_comments = @client.comments(@issue)

    assert_equal(new_comments.size, old_comments.size + 1)
  end

  def test_update_issue_asignee
    assert @client.update_issue_assignee(@issue, "chris")
  end

  def test_issue_transitions
    assert @client.current_transitions(@issue)
  end

  def test_update_issue_transition
    transitions = @client.current_transitions(@issue)
    assert @client.update_issue_transition(@issue, transitions.first.id), @client.latest_error.to_s
  end

  def test_add_label_to_issue
    labels = @client.issue_labels( @issue )
    @client.add_label_to_issue(@issue, "label_#{rand(0..10_000_000)}")
    new_labels = @client.issue_labels( @issue )

    assert_equal (labels.size + 1), new_labels.size
  end
end
