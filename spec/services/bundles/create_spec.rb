RSpec.describe Bundles::Create do
  subject { described_class.call(topics: topics) }

  let(:provider_a) { build_stubbed(:provider, name: "provider_a", topics: "math+science") }
  let(:provider_b) { build_stubbed(:provider, name: "provider_b", topics: "reading+science") }
  let(:provider_c) { build_stubbed(:provider, name: "provider_c", topics: "history+math") }

  context "with parameters from document" do
    before do
      allow(Provider).to receive(:by_topics).and_return([provider_a, provider_b, provider_c])
    end

    let(:topics) do
      {
        "reading" => 20,
        "math" => 50,
        "science" => 30,
        "history" => 15,
        "art" => 10
      }
    end

    it 'searches for providers by topics' do
      expect(Provider).to receive(:by_topics).with(["math", "science", "reading"])
      subject
    end

    it "returns a hash with the quotes for the providers" do
      expect(subject.quotes).to eq(
        {
          "provider_a" => 8.0, # 10% * (50 + 30) = 8.0 
          "provider_b" => 5.0, # 10% * (20 + 30) = 5.0 
          "provider_c" => 10.0 # 20% * 50 = 10.0
        }
      )
    end
  end
end