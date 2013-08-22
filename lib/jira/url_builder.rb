module Jira
  module URLBuilder
    extend self
    REST_SUBPATH = "/rest/api/2/%s"

    def project_path(id=nil)
      REST_SUBPATH % "project/#{id}"
    end

    def issue_path(id)
      REST_SUBPATH % "issue/#{id}"
    end

    def issue_comment_path(issue_id)
      REST_SUBPATH % "issue/#{issue_id}/comment"
    end

    def issue_assignee_path(issue_id)
      REST_SUBPATH % "issue/#{issue_id}/assignee"
    end

    def issue_transitions_path(issue_id)
      REST_SUBPATH % "issue/#{issue_id}/transitions?expand=transitions.fields"
    end

    def statuses_path
      REST_SUBPATH % 'status'
    end
  end
end
