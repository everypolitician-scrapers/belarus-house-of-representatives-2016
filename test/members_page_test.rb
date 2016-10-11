# frozen_string_literal: true
require_relative '../lib/members_page'

describe 'MembersPage' do
  def fixture
    '<html></html>'
  end

  it 'returns an empty array of members from an empty page' do
    page = MembersPage.new('http://example.com')

    # allow(page).to_receive(:html).and_return(fixtures)

    page.to_h[:members].must_equal []

  end
end
