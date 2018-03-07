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
  new_hash = Hash.new
  new_hash[:key] = story.attrs['key']
  #how do we find summary, instead of description?
  new_hash[:description] = story.attrs['fields']['description']
  jira_keys << new_hash
end

def formatted_jira_keys(jira_keys)
  jira_keys.each do |jira|
    jira.each do |key, value|
      string_of_dashes
      puts key.to_s + ':' + value
    end
  end


string_of_dashes
end

def string_of_dashes(length = 10)
  length.times { print '-'}
  print "\n"
end

formatted_jira_keys(jira_keys)


binding.pry


#program block returns each story preferably in binding.pry
#stories.each { |story| puts story.attrs['fields']['issuetype']['name'] }


# individual = issues[0]
#
# individual.attrs.each_key { |key| puts key}


# mine = client.Issue.jql("ASSIGNEE = \"#{config_jira_hash[:assignee]}\""
#                         order by "LAST VIEWED = \"#{config_jira_hash[:last_viewed]}\" DESC")


binding.pry



