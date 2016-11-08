require 'pry'
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
        expect(bibliography_entry.keywords).to contain_exactly("crop model", "environmental impact", "environmental impact", "simulation")
      end
    end
  end
end
