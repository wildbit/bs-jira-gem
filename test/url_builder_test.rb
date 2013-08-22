require 'test/unit'

class UrlBuilderTest < JiraTestCase
  def test_project_path
    assert_equal "/rest/api/2/project/", Jira::URLBuilder.project_path
    assert_equal "/rest/api/2/project/1", Jira::URLBuilder.project_path("1")
  end

  def test_issue_path
    assert_equal "/rest/api/2/issue/1", Jira::URLBuilder.issue_path("1")
  end

  def test_comment_path
    assert_equal "/rest/api/2/issue/1/comment", Jira::URLBuilder.comment_path("1")
  end
end
