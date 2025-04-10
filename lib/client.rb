class Client
    attr_reader :id, :name, :email
  
    def initialize(id:, name:, email:)
      @id = id
      @name = name
      @email = email
    end
  end
  