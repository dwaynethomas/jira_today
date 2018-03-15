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



#give me custom fields that are not nil
def available_custom_fields(story)
  #iterates over story hash and returns custom attributes with data
  story.attrs['fields'].each do |field_name, value|
      if field_name == 'duedate'
        puts field_name
        puts value
     end
  end
  nil
end


available_custom_fields(stories[0])


jira_keys = []
stories.each do |story|
  #creates an hash instead of array to make accessing dataobjects easier.
  new_hash = Hash.new
  new_hash[:issue_no] = story.key
  #how do we find summary, instead of description?
  new_hash[:description] = story.description
  #gets summary value of the jira issue
  new_hash[:summary] = story.summary
  new_hash[:due_date] = Date.parse(story.attrs['fields']['duedate'])

  jira_keys << new_hash
end


#formats keys for printing input
def formatted_jira_keys(jira_keys)
  jira_keys.each do |jira|
    #prints  string at beginning of key pair
    string_of_dashes
    puts 'Issue no.: ' + jira[:issue_no]
    puts 'Summary: ' + jira[:summary][0..100]
    puts 'Due Date: ' + strftime(jira[:due_date]).to_s

  end

binding.pry
exit
  #prints ending string
string_of_dashes

end

def string_of_dashes(length = 20)
  length.times { print '-'}
  print "\n"
end

formatted_jira_keys(jira_keys)




#program block returns each story preferably in binding.pry
#stories.each { |story| puts story.attrs['fields']['issuetype']['name'] }


# individual = issues[0]
#
# individual.attrs.each_key { |key| puts key}


# mine = client.Issue.jql("ASSIGNEE = \"#{config_jira_hash[:assignee]}\""
#                         order by "LAST VIEWED = \"#{config_jira_hash[:last_viewed]}\" DESC")



#File.open('output.txt', 'w') {|file| file.puts stories[0].attrs}


