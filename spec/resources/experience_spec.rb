require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Experience' do
  describe '.persisted?' do
    context 'when experience has no ID' do
      subject { ExperiencesSpain::Experience.new.persisted? }

      it { is_expected.to be_falsy }
    end

    context 'when experience has ID' do
      subject { ExperiencesSpain::Experience.find(1234).persisted? }
      stub_experiences_api(:experience, :find, :porposal)

      it { is_expected.to be_truthy }
    end
  end
end
