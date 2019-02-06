require 'spec_helper'

describe QualtricsAPI::Client do
  subject { QualtricsAPI }

  describe "#response_exports" do
    it "returns a ResponseExportCollection" do
      expect(subject.response_exports).to be_a QualtricsAPI::ResponseExportCollection
    end
  end

  describe "#surveys" do
    it "returns a SurveyCollection" do
      expect(subject.surveys).to be_a QualtricsAPI::SurveyCollection
    end
  end

  describe "#users" do
    it "returns a UserCollection" do
      expect(subject.users).to be_a QualtricsAPI::UserCollection
    end
  end

  describe "#distributions" do
    it "returns a DistributionCollection" do
      expect(subject.distributions).to be_a QualtricsAPI::DistributionCollection
    end
  end

  describe "#groups" do
    it "returns a GroupCollection" do
      expect(subject.groups).to be_a QualtricsAPI::GroupCollection
    end
  end

  describe "#directories" do
    it "returns a DirectoryCollection" do
      expect(subject.directories).to be_a QualtricsAPI::DirectoryCollection
    end
  end

  describe "#initialize" do
    subject { QualtricsAPI::Client }

    it "fails if api_token not provided" do
      expect { subject.new(nil, nil) }.to raise_error('Please provide api token!')
    end

    it 'establishes connection when api_token is provided' do
      client = subject.new('sample_token', 'co1')
      expect(client.connection).not_to be_nil
      expect(client.connection.headers["X-API-TOKEN"]).to eq('sample_token')
    end

    it 'establishes connection to the specified data center' do
      client = subject.new('sample_token', 'somedcid')
      expect(client.connection.url_prefix.to_s).to eq('https://somedcid.qualtrics.com/API/v3/')
    end
  end
end
