# frozen_string_literal: true
require_relative 'page'

class MembersPage < Page
  def next_page_url
    url = noko.css('.p_next/@href').text
    return if url.empty?
    absolute_url(url)
  end

  field :members do
    []
  end

end
