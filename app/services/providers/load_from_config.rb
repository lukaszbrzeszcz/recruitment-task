
module Providers
  class LoadFromConfig
    include Interactor

    def call
      providers = provider_topics.each_with_object([]) do |(name, topics), arr|
        arr << Provider.new(name: name, topics: topics)
      end

      Provider.import(providers)
    end

    private

    def provider_topics
      json['provider_topics']
    end

    def json
      JSON.parse(file)
    end

    def file
      File.read(config_path)
    end

    def config_path
      Rails.root.join('config', 'providers.json')
    end
  end
end
