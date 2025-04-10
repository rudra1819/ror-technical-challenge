require 'json'
require_relative 'client'

class ClientRepository
  def initialize(file_path)
    @file_path = file_path
    @clients = load_clients
  end

  def all
    @clients
  end

  private

  def load_clients
    file = File.read(@file_path)
    data = JSON.parse(file)

    data.map do |client_hash|
      Client.new(
        id: client_hash["id"],
        name: client_hash["name"],
        email: client_hash["email"]
      )
    end
  end
end
