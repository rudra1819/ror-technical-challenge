# spec/client_repository_spec.rb

require_relative '../lib/client_repository'
require_relative '../lib/client'
require 'json'
require 'tempfile'

RSpec.describe ClientRepository do
  describe '#all' do
    it 'loads clients from a JSON file and returns an array of Client objects' do
      # Create sample data for testing.
      sample_data = [
        { "id" => 1, "name" => "Alice", "email" => "alice@example.com" },
        { "id" => 2, "name" => "Bob", "email" => "bob@example.com" }
      ]

      # Use Tempfile to write sample JSON data.
      Tempfile.create('clients.json') do |file|
        file.write(sample_data.to_json)
        file.rewind  # Go back to the beginning of the file for reading.

        repo = ClientRepository.new(file.path)
        clients = repo.all

        # Verify the output is an array and contains Client objects.
        expect(clients).to be_an(Array)
        expect(clients.size).to eq(2)
        expect(clients.first).to be_a(Client)
        expect(clients.first.name).to eq("Alice")
      end
    end
  end
end
