class BibliographyEntry
  def initialize(xml)
    @keywords = xml.xpath('//keyword').map(&:text)
  end

  def keywords
    @keywords
  end
end
