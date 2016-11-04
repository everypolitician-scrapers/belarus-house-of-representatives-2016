#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'

require_rel 'lib'

page = MembersPage.new(url: 'http://house.gov.by/ru/deputies-ru/')
members = page.mp_page_urls.map do |url|
  MemberPage.new(url: url)
end
binding.pry
