require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe 'Image' do
  describe '.save' do
    subject { ExperiencesSpain::Image.new(image: 'Base64-Encoded-Image') }

    context 'when image is not valid' do
      stub_experiences_api(:image, :save, :invalid)

      it 'should be falsy' do
        expect(subject.save).to be_falsy
      end
    end

    context 'when image is valid' do
      stub_experiences_api(:image, :save, :valid)

      it 'should be truthy' do
        expect(subject.save).to be_truthy
      end

      it 'cleans the image data' do
        expect(subject.image).not_to be_nil
        subject.save
        expect(subject.image).to be_nil
      end

      it 'retrieve the image url' do
        expect(subject.url).to be_nil
        subject.save
        expect(subject.url).not_to be_nil
      end
    end
  end
end
