require 'rails_helper'

RSpec.describe Provider, type: :model do
  describe "scopes" do
    describe ".by_topics" do
      let(:provider_a) { build(:provider, name: "provider_a", topics: "math+science") }
      let(:provider_b) { build(:provider, name: "provider_b", topics: "reading+science") }
      let(:provider_c) { build(:provider, name: "provider_c", topics: "history+math") }

      before do
        Provider.import([provider_a, provider_b, provider_c])
      end

      it "returns the providers that match the topics" do
        expect(Provider.by_topics(["math", "history"]).pluck(:name)).to contain_exactly("provider_a", "provider_c")
      end
    end
  end
end
