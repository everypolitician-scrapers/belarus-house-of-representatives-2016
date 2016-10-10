#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'

require_rel 'lib'

page = MembersPage.new('http://house.gov.by/ru/deputies-ru/')

while(next_url = page.next_page_url) do
  puts next_url
  page = MembersPage.new(next_url)
end
