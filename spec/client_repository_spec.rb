require_relative '../lib/client_repository'
require_relative '../lib/client'
require 'json'
require 'tempfile'

RSpec.describe ClientRepository do
  describe '#all' do
    it 'loads clients from a JSON file and returns an array of Client objects' do
      sample_data = [
        { "id" => 1, "name" => "Alice", "email" => "alice@example.com" },
        { "id" => 2, "name" => "Bob", "email" => "bob@example.com" }
      ]

      Tempfile.create('clients.json') do |file|
        file.write(sample_data.to_json)
        file.rewind  

        repo = ClientRepository.new(file.path)
        clients = repo.all

        expect(clients).to be_an(Array)
        expect(clients.size).to eq(2)
        expect(clients.first).to be_a(Client)
        expect(clients.first.name).to eq("Alice")
      end
    end
  end
end
