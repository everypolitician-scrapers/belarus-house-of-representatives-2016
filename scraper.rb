#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'nokogiri'
#require 'open-uri/cached'
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

page = Page.new('http://house.gov.by/ru/deputies-ru/')

while(next_path = page.noko.css('.p_next/@href').text) do
  next_url = page.absolute_url(next_path)
  puts next_url
  page = Page.new(next_url)
end
