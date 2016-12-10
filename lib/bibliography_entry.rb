class BibliographyEntry
  def initialize(xml)
    @keywords = xml.xpath('//keyword').map(&:text)
  end

  def keywords
    @keywords
  end

  def has_tags?(tags)
    tags.map do |tag|
      @keywords.include?(tag)
    end.reduce(:|)
  end
end
