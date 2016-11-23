require_relative '../lib/data_importer'

RSpec.describe DataImporter do
  describe '#new' do
    it 'raises ArgumentError if no argument is given' do
      expect { DataImporter.new() }.to raise_exception(ArgumentError)
    end

    it 'raises an error if the argument is not a valid path' do
      expect { DataImporter.new('not/a/valid/path') }.to(
        raise_exception(Errno::ENOENT)
      )
    end

    it 'calls Nokogiri::XML with the given path' do
      allow(Nokogiri).to receive(:XML)
      DataImporter.new('spec/fixtures/empty.xml')
      expect(Nokogiri).to have_received(:XML) do |arg|
        expect(arg.path).to eq('spec/fixtures/empty.xml')
      end
    end
  end

  describe '#get_objects' do
    context 'with an empty xml' do
      it 'returns an array' do
        imported = DataImporter.new('spec/fixtures/empty.xml').get_objects
        expect(imported).to be_an(Array)
      end

      it 'returns an empty array' do
        imported = DataImporter.new('spec/fixtures/empty.xml').get_objects
        expect(imported).to be_empty
      end
    end
    context 'with a non-empty xml' do
      it 'returns an array' do
        imported = DataImporter.new('spec/fixtures/not_empty.xml').get_objects
        expect(imported).to be_an(Array)
      end

      it 'returns an array of BibliographyEntries' do
        imported = DataImporter.new('spec/fixtures/not_empty.xml').get_objects
        imported.each do |array_element|
          expect(array_element).to be_a(BibliographyEntry)
        end
      end
    end
  end
end
