require_relative '../lib/bibliography_sorter'

describe 'BibliographySorter' do
  describe '::new' do
    it 'takes an argument' do
      expect { BibliographySorter.new() }.to raise_exception(ArgumentError)
    end

    it 'calls the DataImporter with the given path' do
      allow(DataImporter).to receive(:new).and_return(DataImporter.new('spec/fixtures/empty.xml'))
      BibliographySorter.new('a/path')
      expect(DataImporter).to have_received(:new).with('a/path')
    end

    it 'calls #get_objects upon the DataImporter instance' do
      data_importer_instance = double('DataImporterInstance')
      allow(data_importer_instance).to receive(:get_objects)
      allow(DataImporter).to receive(:new).and_return(data_importer_instance)
      BibliographySorter.new('some/path')
      expect(data_importer_instance).to have_received(:get_objects)
    end
  end

  describe '#filter_by_tag' do
    it 'returns an array' do
      sorter = BibliographySorter.new('spec/fixtures/empty.xml')
      expect(sorter.filter_by_tag([])).to be_an(Array)
    end

    it 'returns the articles that contain any of the given tags' do
      sorter = BibliographySorter.new('spec/fixtures/not_empty.xml')
      results = sorter.filter_by_tag(['Population regulation'])
      results.each do |entry|
        expect(entry.keywords).to include('Population regulation')
      end
    end
  end
end
