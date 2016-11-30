#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'

require_rel 'lib'

page = MembersPage.new(response: Scraped::Request.new(url: 'http://house.gov.by/ru/deputies-ru/').response)

while (next_url = page.next_page_url)
  puts next_url
  page = MembersPage.new(response: Scraped::Request.new(url: 'http://house.gov.by/ru/deputies-ru/').response)
end
