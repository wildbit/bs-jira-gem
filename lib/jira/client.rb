require 'jira/url_builder'
require 'jira/models'
require 'httparty'
require 'json'

module Jira
  class Client
    include HTTParty
    include URLBuilder
    include Models

    attr_accessor :latest_error

    def initialize(url, username, password)
      self.class.base_uri(url)
      self.class.headers(default_headers)

      @auth_options = { username: username, password: password }
    end

    def connects?
      !projects.nil?
    end

    def projects
      @projects ||= find_projects
    end

    def comments(issue_id)
      find_comments(issue_id)
    end

    # write operations

    def post_comment(issue_id, comment_body)
      clear_error
      options = default_options(body: { body: comment_body }.to_json)

      raw_comment = self.class.post(comment_path(issue_id), options)

      if raw_comment["errorMessages"]
        self.latest_error = raw_comment["errorMessages"]
      end
    end

    # error handling

    def error_occurred?
      !latest_error.nil?
    end

    def clear_error
      self.latest_error = nil
    end

    private

    def find_projects
      clear_error
      raw_projects = self.class.get(project_path, default_options)

      raw_projects.map do |raw_project|
        build_project(raw_project)
      end
    end

    def find_comments(issue_id)
      clear_error
      raw_comments = self.class.get(comment_path(issue_id), default_options)

      raw_comments["comments"].map do |raw_comment|
        build_comment(raw_comment)
      end
    end

    def default_options(options={})
      { basic_auth: @auth_options }.merge(options)
    end

    def default_headers
      { 'Content-Type' => 'application/json', 'Accept-Encoding' => 'gzip, deflate' }
    end
  end
end
