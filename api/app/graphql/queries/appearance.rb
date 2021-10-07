module Queries
  class Appearance < Queries::BaseQuery
    type Types::AppearanceType, null: false

    def resolve
      { message: 'hello' }
    end
  end
end