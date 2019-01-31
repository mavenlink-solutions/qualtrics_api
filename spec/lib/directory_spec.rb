require "spec_helper"

describe QualtricsAPI::Directory do
  subject { described_class.new qualtrics_response }
  let(:directory_mailing_list_collection_double) { instance_double(QualtricsAPI::DirectoryMailingListCollection) }
  let(:qualtrics_response) { {
    "directoryId" => "POOL_abc123",
    "name" => "Directory 123",
    "contactCount" => 3,
    "isDefault" => true
  } }

  before do
    allow(QualtricsAPI::DirectoryMailingListCollection).to receive(:new) { directory_mailing_list_collection_double }
    allow(directory_mailing_list_collection_double).to receive(:propagate_connection) { directory_mailing_list_collection_double }
  end

  it { is_expected.to have_attributes(
    directory_id: qualtrics_response["directoryId"],
    name: qualtrics_response["name"],
    contact_count: qualtrics_response["contactCount"],
    is_default: qualtrics_response["isDefault"])
  }

  describe "#mailing_lists" do
    before do
      allow(directory_mailing_list_collection_double).to receive(:all)
    end

    after do
      subject.mailing_lists
    end

    it "creates a DirectoryMailingListCollection with the same connection" do
      expect(QualtricsAPI::DirectoryMailingListCollection).to receive(:new).with(id: subject.directory_id)
      expect(directory_mailing_list_collection_double).to receive(:propagate_connection).with(subject)
    end

    it "calls all on the directory mailing list collection" do
      expect(directory_mailing_list_collection_double).to receive(:all)
    end
  end

  describe "#create_mailing_list" do
    let(:directory_mailing_list_double) { instance_double(QualtricsAPI::DirectoryMailingList) }

    before do
      allow(directory_mailing_list_collection_double).to receive(:create_mailing_list)
    end

    after do
      subject.create_mailing_list(directory_mailing_list_double)
    end

    it "creates a DirectoryMailingListCollection with the same connection" do
      expect(QualtricsAPI::DirectoryMailingListCollection).to receive(:new).with(id: subject.directory_id)
      expect(directory_mailing_list_collection_double).to receive(:propagate_connection).with(subject)
    end

    it "calls create on the directory mailing list collection with the given directory mailing list" do
      expect(directory_mailing_list_collection_double).to receive(:create_mailing_list).with(directory_mailing_list_double)
    end
  end
end
