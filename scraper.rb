#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'
require 'scraped_page_archive/open-uri'

require_rel 'lib'

page = MembersPage.new(
  response: Scraped::Request.new(
    url: 'http://house.gov.by/ru/deputies-ru/'
  ).response
)

puts page.member_urls
