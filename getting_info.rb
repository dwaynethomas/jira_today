require 'jira-ruby' #loads only if jira-ruby not loaded yet
require 'pry'
require 'yaml'

config_jira_hash = YAML.load_file('donotpush_folder/donotpush_jira.yml')

config_personal_auth = YAML.load_file('donotpush_folder/donotpush_auth_info.yml')


#hash-long list defined all at once, rockets used
options = {
    :username     => config_personal_auth[:username],
    :password     => config_personal_auth[:password],
    :site         => config_jira_hash[:site],
    :context_path => '',
    :auth_type    => :basic
}

# module jira, has client definition, instantiated with options as its initialized
client = JIRA::Client.new(options)

# instance, uses class method find inside Project class
# project = client.Project.find(config_personal_hash[:project_name])

# issues reported by me
 issues = client.Filter.find(14725).issues

#find issues that are of type story
stories = []
issues.each do |issue|
  if issue.attrs['fields']['issuetype']['name'] == 'Story'
    stories << issue
  end
end

jira_keys = []
    stories.each do |story|
    jira_keys << story.attrs['key']
    #how do we find summary, instead of description?
    jira_keys << story.attrs['fields']['description']
    end

binding.pry


#program block returns each story preferably in binding.pry
#stories.each { |story| puts story.attrs['fields']['issuetype']['name'] }


# individual = issues[0]
#
# individual.attrs.each_key { |key| puts key}


# mine = client.Issue.jql("ASSIGNEE = \"#{config_jira_hash[:assignee]}\""
#                         order by "LAST VIEWED = \"#{config_jira_hash[:last_viewed]}\" DESC")


binding.pry



