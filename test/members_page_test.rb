# frozen_string_literal: true
require_rel 'page'

describe 'MembersPage' do
  def fixtures
    '<html></html>'
  end

  it 'returns an empty array of members from an empty page' do
    page = MembersPage.new('http://example.com')
    allow(page).to_receive(:html).and_return(fixtures)
  end
end
