# frozen_string_literal: true
require 'scraped'

class MembersPage < Scraped::HTML
  decorator AbsoluteLinks
  field :member_urls do
    noko.css('.news_title.dep_fio a/@href').map(&:text)
  end
end
