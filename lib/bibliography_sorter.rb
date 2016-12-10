require_relative 'data_importer'

class BibliographySorter
  def initialize(path)
    @entries = DataImporter.new(path).get_objects
  end

  def filter_by_tag(tags)
    @entries.select do |entry|
      entry.has_tags?(tags)
    end
  end
end
