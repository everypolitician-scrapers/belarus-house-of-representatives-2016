#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'

require_rel 'lib'

page = Page.new('http://house.gov.by/ru/deputies-ru/')

while(next_path = page.noko.css('.p_next/@href').text) do
  next_url = page.absolute_url(next_path)
  puts next_url
  page = Page.new(next_url)
end
