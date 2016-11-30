#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'
require 'scraperwiki'

require_rel 'lib'

MembersPage.new(
  response: Scraped::Request.new(
    url: 'http://house.gov.by/ru/deputies-ru/'
  )
                             .response(decorators: [AbsoluteLinks])
).member_urls.each do |member_url|
  member_page = MemberPage.new(response: Scraped::Request.new(url: member_url).response)
  ScraperWiki.save_sqlite([:id, :term], member_page.to_h)
end
