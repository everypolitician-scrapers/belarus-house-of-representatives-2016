require 'minitest/autorun'
require_relative '../lib/member_page'

describe 'MemberPage' do
  it 'creates a page from a url' do
    page = MemberPage.new('http://example.com')
  end
end
