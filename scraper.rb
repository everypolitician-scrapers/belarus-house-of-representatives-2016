#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'
require 'scraperwiki'

require_rel 'lib'

MembersPage.new(
  response: Scraped::Request.new(url: 'http://house.gov.by/ru/deputies-ru/').response
)
           .mp_page_urls.each do |url|
             ScraperWiki.save_sqlite([:name], MemberPage.new(
               response: Scraped::Request.new(url: url).response
             ).to_h)
           end
