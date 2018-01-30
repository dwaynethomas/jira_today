require 'jira-ruby' #loads only if jira-ruby not loaded yet
require 'pry'
personal_information =[]

#class method
File.open('donotpush_config.txt').each do |line|
  personal_information << line.chomp #takes last element without white space and adds it to the array
end

#instance method
# file = File.new('donotpush_config.txt', 'r')
# personal_information = file.readlines
# file.close

#hash-long list defined all at once, rockets used bc it's a hash
options = {
    :username     => personal_information[0],
    :password     => personal_information[1],
    :site         => personal_information[2],
    :context_path => '',
    :auth_type    => :basic
}

# module jira, has client definition, instantiated with options as its initialized
client = JIRA::Client.new(options)

# instance, uses class method find inside Project class
project = client.Project.find(personal_information[3])

binding.pry