module Jira
  module Models
    Project = Struct.new(:id, :name)
    Issue   = Struct.new(:id, :name)
    Comment = Struct.new(:id, :author, :body)
    Status  = Struct.new(:id, :name)

    def build_project(attrs)
      Project.new(attrs["key"], attrs["name"])
    end

    def build_issue(attrs)
      Issue.new(attrs["key"], attrs["name"])
    end

    def build_comment(attrs)
      author = attrs["author"]["name"] if attrs["author"]
      Comment.new(attrs["id"], author, attrs["body"])
    end

    def build_status(attrs)
      Status.new(attrs["id"], attrs["name"])
    end
  end
end
