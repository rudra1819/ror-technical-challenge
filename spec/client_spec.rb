require_relative '../lib/client'

RSpec.describe Client do
  describe '#initialize' do
    it 'sets the id, name, and email attributes' do
      client = Client.new(id: 1, name: 'Test bharat', email: 'test@example.com')

      expect(client.id).to eq(1)
      expect(client.name).to eq('Test bharat')
      expect(client.email).to eq('test@example.com')
    end
  end
end
