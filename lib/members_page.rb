# frozen_string_literal: true
require 'scraped'

class MembersPage < Scraped::HTML
  decorator Scraped::Response::Decorator::AbsoluteUrls
  field :member_urls do
    noko.css('#by_alf_info .news_item > a/@href').map(&:text)
  end
end
