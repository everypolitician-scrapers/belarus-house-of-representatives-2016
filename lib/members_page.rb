# frozen_string_literal: true
require 'scraped'

class MembersPage < Scraped::HTML

  def mp_page_urls
    noko.css('.news_title.dep_fio a/@href').map(&:text)
  end
end
