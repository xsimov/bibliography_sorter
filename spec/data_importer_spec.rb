require_relative '../lib/data_importer'

RSpec.describe DataImporter do
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
