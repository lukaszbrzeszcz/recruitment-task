module Bundles
  class Create
    include Interactor

    delegate :topics, :model, to: :context

    def call
      context.quotes = Provider.by_topics(top_three_topics).each_with_object({}) do |provider, quotes|
        matches = provider.topics.split("+") & top_three_topics
        quotes[provider.name] = matches.size == 2 ? two_topic_quote(matches) : one_topic_quote(matches.first)
      end
    end

    private

    def sorted_topics
      topics.sort_by { |_k, v| -v }
    end

    def top_three_topics
      @top_three_topics ||= sorted_topics.first(3).map(&:first)
    end

    def two_topic_quote(matches)
      (0.1 * matches.sum { |t| topics[t] }).round(2)
    end

    def one_topic_quote(topic)
      importance = top_three_topics.index(topic)
      percentage = [0.2, 0.25, 0.3][importance]

      (percentage * topics[topic]).round(2)
    end
  end
end
