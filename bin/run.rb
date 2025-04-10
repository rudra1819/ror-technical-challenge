require_relative '../lib/client_repository'
require_relative '../lib/search_service'
require 'optparse'

def print_usage
  puts "Usage:"
  puts "  ruby bin/run.rb search --query QUERY"
  puts "  ruby bin/run.rb duplicates"
end

if ARGV.empty?
  print_usage
  exit
end

command = ARGV.shift

json_file_path = File.join(File.dirname(__FILE__), '../clients.json')

repo = ClientRepository.new(json_file_path)
clients = repo.all

service = SearchService.new(clients)

case command
when "search"
  options = {}
  
  OptionParser.new do |opts|
    opts.banner = "Usage: ruby bin/run.rb search --query QUERY"
    opts.on("-qQUERY", "--query=QUERY", "Query string to search client names") do |q|
      options[:query] = q
    end
  end.parse!(ARGV)

  if options[:query].nil? || options[:query].strip.empty?
    puts "Error: Query string is required."
    print_usage
    exit 1
  end

  results = service.search_by_name(options[:query])
  
  if results.empty?
    puts "No clients found for query '#{options[:query]}'."
  else
    puts "Clients found:"
    results.each do |client|
      puts "ID: #{client.id}, Name: #{client.name}, Email: #{client.email}"
    end
  end

when "duplicates"
  results = service.find_duplicate_emails
  
  if results.empty?
    puts "No duplicate emails found."
  else
    puts "Clients with duplicate emails:"
    results.each do |client|
      puts "ID: #{client.id}, Name: #{client.name}, Email: #{client.email}"
    end
  end

else
  print_usage
  exit 1
end
