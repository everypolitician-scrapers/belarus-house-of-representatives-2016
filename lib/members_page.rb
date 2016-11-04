# frozen_string_literal: true
require 'scraped_page'

class MembersPage < ScrapedPage

  def mp_page_urls
    urls = noko.css('.news_title.dep_fio a/@href').map(&:text)
  end

  def next_page_url
    url = noko.css('.p_next/@href').text
    return if url.empty?
    absolute_url(url)
  end
end
