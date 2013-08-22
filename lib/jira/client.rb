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

    def statuses
      @statuses ||= find_statuses
    end

    def comments(issue_id)
      find_comments(issue_id)
    end

    def current_transitions(issue_id)
      find_issue_transitions(issue_id)
    end

    # write operations

    def post_comment(issue_id, comment_body)
      clear_error
      options = default_options(body: { body: comment_body }.to_json)

      response = self.class.post(issue_comment_path(issue_id), options)
      determine_error_status(response)
    end

    def update_issue_assignee(issue_id, assignee_name)
      clear_error
      options = default_options(body: { name: assignee_name }.to_json)

      response = self.class.put(issue_assignee_path(issue_id), options)
      determine_error_status(response)
    end

    def update_issue_transition(issue_id, transition_id)
      clear_error
      options = default_options(body: { transition: { id: transition_id } }.to_json)

      response = self.class.post(issue_transitions_path(issue_id), options)
      determine_error_status(response)
    end

    # error handling

    def error_occurred?
      !latest_error.nil?
    end

    private

    def find_projects
      raw_projects = find(project_path, default_options)

      raw_projects.map do |raw_project|
        build_project(raw_project)
      end
    end

    def find_statuses
      raw_statuses = find(statuses_path, default_options)

      raw_statuses.map do |raw_status|
        build_status(raw_status)
      end
    end

    def find_comments(issue_id)
      raw_comments = find(issue_comment_path(issue_id), default_options)

      raw_comments["comments"].map do |raw_comment|
        build_comment(raw_comment)
      end
    end

    def find_issue_transitions(issue_id)
      clear_error

      raw_transitions = find(issue_transitions_path(issue_id), default_options)

      raw_transitions["transitions"].map do |raw_transition|
        generic_build(Transition, raw_transition)
      end
    end

    def find(path, options)
      clear_error
      self.class.get(path, options)
    end

    def clear_error
      self.latest_error = nil
    end

    def default_options(options={})
      { basic_auth: @auth_options }.merge(options)
    end

    def default_headers
      { 'Content-Type' => 'application/json' }
    end

    def determine_error_status(response)
      if response["errorMessages"]
        self.latest_error = response["errorMessages"]
        false
      else
        true
      end
    end
  end
end
