# frozen_string_literal: true
require 'scraped_page'

class MembersPage < ScrapedPage
  def next_page_url
    url = noko.css('.p_next/@href').text
    return if url.empty?
    absolute_url(url)
  end
end
