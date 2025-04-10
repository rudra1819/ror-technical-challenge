class SearchService
    def initialize(clients)
      @clients = clients
    end
  
    def search_by_name(query)
      lower_query = query.downcase
      @clients.select do |client|
        client.name.downcase.include?(lower_query)
      end
    end
  
    def find_duplicate_emails
      email_groups = @clients.group_by { |client| client.email.downcase }
  
      email_groups.select { |email, clients| clients.size > 1 }.values.flatten
    end
  end
  