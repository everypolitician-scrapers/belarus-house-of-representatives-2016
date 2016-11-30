# frozen_string_literal: true
require 'scraped'

class MembersPage < Scraped::HTML
  def next_page_url
    url = noko.css('.p_next/@href').text
    return if url.empty?
    url
  end
end
