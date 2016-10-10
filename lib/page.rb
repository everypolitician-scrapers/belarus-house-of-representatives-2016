# frozen_string_literal: true
require 'nokogiri'
# require 'open-uri/cached'
require 'scraped_page_archive/open-uri'
require 'field_serializer'

class String
  def tidy
    gsub(/[[:space:]]+/, ' ').strip
  end
end

class Page
  include FieldSerializer

  def initialize(url)
    @url = url
  end

  def noko
    @noko ||= Nokogiri::HTML(open(url).read)
  end

  def absolute_url(rel)
    return if rel.to_s.empty?
    URI.join(url, URI.encode(URI.decode(rel)))
  end

  private

  attr_reader :url
end
