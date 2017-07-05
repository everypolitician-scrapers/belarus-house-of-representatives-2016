#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'
require 'scraperwiki'

require 'scraped_page_archive/open-uri'
# require 'open-uri/cached'
# OpenURI::Cache.cache_path = '.cache'

require_rel 'lib'

def scrape(h)
  url, klass = h.to_a.first
  klass.new(response: Scraped::Request.new(url: url).response)
end

start = 'http://house.gov.by/ru/sozyvy-ru/view/shestoj-sozyv-15/'
data = scrape(start => MembersPage).member_urls.map do |member_url|
  scrape(member_url => MemberPage).to_h.merge(term: 6)
end
data.each { |mem| puts mem.reject { |_, v| v.to_s.empty? }.sort_by { |k, _| k }.to_h } if ENV['MORPH_DEBUG']

ScraperWiki.sqliteexecute('DROP TABLE data') rescue nil
ScraperWiki.save_sqlite(%i[id term], data)
