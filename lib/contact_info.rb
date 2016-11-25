require 'nokogiri'

class ContactInfo
  def initialize(noko)
    @noko = noko
  end

  def email_addresses
    just_addresses(lines_containing('@')).flat_map do |str|
      str.split(',')
         .map { |i| i.gsub(/\.$/, '') }
    end
  end

  def website_addresses
    just_addresses(lines_containing('http')).flat_map do |str|
      str.split(',')
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
