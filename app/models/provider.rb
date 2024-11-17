class Provider < ApplicationRecord
  scope :by_topics, ->(topics) {
    where("topics ILIKE '%#{topics.join("%' OR topics ILIKE '%")}%'")
  }
end
