#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'
require 'scraped_page_archive/open-uri'
require 'scraperwiki'

require_rel 'lib'

ScraperWiki.sqliteexecute('DROP TABLE data') rescue nil

MembersPage.new(
  response: Scraped::Request.new(url: 'http://house.gov.by/ru/sozyvy-ru/view/shestoj-sozyv-15/').response
).member_urls.each do |member_url|
  response = Scraped::Request.new(url: member_url).response
  data = MemberPage.new(response: response).to_h.merge(term: 6)
  ScraperWiki.save_sqlite(%i[id term], data)
end
