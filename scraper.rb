#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'nokogiri'
require 'open-uri/cached'
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

  private

  attr_reader :url
end

page = Page.new('http://house.gov.by/ru/deputies-ru/indexPerson/curr_conv/14/page/2').noko
