#!/bin/env ruby
# encoding: utf-8
# frozen_string_literal: true

require 'pry'
require 'require_all'

require_rel 'lib'

page = MembersPage.new(url: 'http://house.gov.by/ru/deputies-ru/')
urls = page.mp_page_urls
