# frozen_string_literal: true

require 'scraped'

class MembersPage < Scraped::HTML
  decorator Scraped::Response::Decorator::AbsoluteUrls
  field :member_urls do
    noko.xpath('//div[contains(@id,"by_alf_inner")]/div[contains(@class,"news_item_second")]/a/@href').map(&:text)
  end
end
