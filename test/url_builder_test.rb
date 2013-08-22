require 'test/unit'

class UrlBuilderTest < JiraTestCase
  def test_project_path
    assert_equal "/rest/api/2/project/", Jira::URLBuilder.project_path
    assert_equal "/rest/api/2/project/1", Jira::URLBuilder.project_path("1")
  end

  def test_issue_path
    assert_equal "/rest/api/2/issue/1", Jira::URLBuilder.issue_path("1")
  end

  def test_issue_assignee_path
    assert_equal "/rest/api/2/issue/1/assignee", Jira::URLBuilder.issue_assignee_path("1")
  end

  def test_issue_comment_path
    assert_equal "/rest/api/2/issue/1/comment", Jira::URLBuilder.issue_comment_path("1")
  end

  def test_statuses_path
    assert_equal "/rest/api/2/status", Jira::URLBuilder.statuses_path
  end
end
