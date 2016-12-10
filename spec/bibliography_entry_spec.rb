require 'nokogiri'
require_relative '../lib/bibliography_entry'

describe BibliographyEntry do
  describe '#keywords' do
    it 'returns an array' do
      bibliography_entry = BibliographyEntry.new(Nokogiri::XML(''))
      expect(bibliography_entry.keywords).to be_an(Array)
    end

    context 'with an empty xml object' do
      it 'returns an empty array' do
        bibliography_entry = BibliographyEntry.new(Nokogiri::XML(''))
        expect(bibliography_entry.keywords).to be_empty
      end
    end

    context 'with an entry xml object' do
      it 'returns the keywords as strings' do
        xml_obj = File.open('spec/fixtures/entry_object.xml') { |f| Nokogiri::XML(f) }
        bibliography_entry = BibliographyEntry.new(xml_obj)
        expect(bibliography_entry.keywords).not_to be_empty
        expect(bibliography_entry.keywords.length).to eq(4)
        bibliography_entry.keywords.each do |keyword|
          expect(keyword).to be_a(String)
        end
      end

      it 'returns only unique keywords' do
        xml_obj = File.open('spec/fixtures/entry_object.xml') { |f| Nokogiri::XML(f) }
        bibliography_entry = BibliographyEntry.new(xml_obj)
        keywords = ['crop model', 'environmental impact', 'environmental impact', 'simulation']
        expect(bibliography_entry.keywords).to contain_exactly(*keywords)
      end
    end
  end

  describe '#has_tags?' do
    it 'returns true if the entry contains any of the given tags' do
      xml_obj = File.open('spec/fixtures/entry_object.xml') { |f| Nokogiri::XML(f) }
      bibliography_entry = BibliographyEntry.new(xml_obj)
      keywords = ['crop model', 'simulation', 'not a valid tag']
      expect(bibliography_entry).to have_tags(keywords)
    end

    it 'returns false if the entry does not contain any of the given tags' do
      xml_obj = File.open('spec/fixtures/entry_object.xml') { |f| Nokogiri::XML(f) }
      bibliography_entry = BibliographyEntry.new(xml_obj)
      keywords = ['something', 'other than', 'a valid tag']
      expect(bibliography_entry).not_to have_tags(keywords)
    end
  end
end
