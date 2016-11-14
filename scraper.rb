#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'
require 'scraperwiki'

require_rel 'lib'

page = MembersPage.new(url: 'http://house.gov.by/ru/deputies-ru/')
page.mp_page_urls.map do |url|
  ScraperWiki.save_sqlite([:name], MemberPage.new(url: url).to_h)
end
