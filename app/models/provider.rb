class Provider < ApplicationRecord
  scope :by_topics, ->(topics) {
    where(Arel.sql("topics ILIKE '%#{topics.join("%' OR topics ILIKE '%")}%'"))
  }
end
