require_relative '../lib/search_service'
require_relative '../lib/client'

RSpec.describe SearchService do
  before(:each) do
    
    @clients = [
      Client.new(id: 1, name: "John Doe", email: "john@example.com"),
      Client.new(id: 2, name: "Jane Doe", email: "jane@example.com"),
      Client.new(id: 3, name: "Johnny Appleseed", email: "john@example.com"), 
      Client.new(id: 4, name: "Alice Wonderland", email: "alice@example.com")
    ]
    @service = SearchService.new(@clients)
  end

  describe '#search_by_name' do
    it 'returns matching clients based on partial name (case insensitive)' do
      result = @service.search_by_name("john")
      expect(result.size).to eq(2)
      expect(result.map(&:name)).to include("John Doe", "Johnny Appleseed")
    end

    it 'returns an empty array if no clients match the search query' do
      result = @service.search_by_name("zxy")
      expect(result).to be_empty
    end
  end

  describe '#find_duplicate_emails' do
    it 'finds clients with duplicate emails' do
      duplicates = @service.find_duplicate_emails
      expect(duplicates.size).to eq(2)
      expect(duplicates.map(&:email).uniq.first.downcase).to eq("john@example.com")
    end

    it 'returns an empty array if no duplicate emails are found' do
      service_no_duplicates = SearchService.new([
        Client.new(id: 5, name: "Unique User", email: "unique@example.com")
      ])
      expect(service_no_duplicates.find_duplicate_emails).to be_empty
    end
  end
end
