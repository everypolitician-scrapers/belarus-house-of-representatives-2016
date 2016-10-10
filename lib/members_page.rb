require_rel 'page'

class MembersPage < Page
  def next_page_url
    noko.css('.p_next/@href').text
  end
end
