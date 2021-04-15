module Projects
  class Contributor < ApplicationModel
    attribute :username, Types::String
    attribute :rank, Types::Integer
  end
end
