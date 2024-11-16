module Providers
  class DeleteAll
    include Interactor

    def call
      Provider.delete_all
    end
  end
end
