require 'nokogiri'

class ContactInfo
  def initialize(noko)
    @noko = noko
  end

  def email_addresses
    just_addresses(lines_containing('@')).flat_map do |str|
      str.split(',')
    end
  end

  def website_addresses
    body_text.select do |str|
      str.include?('http')
    end
  end

  private

  attr_reader :noko

  def body_text
    noko.map(&:text)
  end

  def lines_containing(sub_str)
    body_text.select do |str|
      str.include?(sub_str)
    end
  end

  def just_addresses(lines)
    lines.map do |str|
      str.split(/:(?!\/\/)/).last
    end
  end
end
