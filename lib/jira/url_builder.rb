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

    def comment_path(issue_id)
      REST_SUBPATH % "issue/#{issue_id}/comment"
    end
  end
end
