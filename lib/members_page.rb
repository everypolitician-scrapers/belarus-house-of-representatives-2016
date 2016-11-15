# frozen_string_literal: true
require 'scraped_page'

class MembersPage < ScrapedPage

  def mp_page_urls
    noko.css('.news_title.dep_fio a/@href').map(&:text)
  end
end
