require 'nokogiri'
require_relative 'bibliography_entry'

class DataImporter
  def initialize(file_path)
    @nokogiri_object = File.open(file_path) { |f| Nokogiri::XML(f) }
  end

  def get_objects
    parse_string.map do |bibliography_obj|
      BibliographyEntry.new(bibliography_obj)
    end
  end

  private

  def parse_string
    @nokogiri_object.xpath('//record')
  end
end
