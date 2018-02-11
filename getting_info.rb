require 'jira-ruby' #loads only if jira-ruby not loaded yet
require 'pry'
require 'yaml'

personal_information =[]

config_jira_hash = YAML.load_file('donotpush_jira.yml')

config_personal_auth = YAML.load_file('donotpush_auth_info.yml')


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

 issue = client.Filter.find(14725).issues


# mine = client.Issue.jql("ASSIGNEE = \"#{config_jira_hash[:assignee]}\""
#                         order by "LAST VIEWED = \"#{config_jira_hash[:last_viewed]}\" DESC")


binding.pry



