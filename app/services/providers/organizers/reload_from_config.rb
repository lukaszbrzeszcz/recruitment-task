module Providers
  module Organizers
    class ReloadFromConfig
      include Interactor::Organizer

      organize ::Providers::DeleteAll,
        ::Providers::LoadFromConfig
    end
  end
end
