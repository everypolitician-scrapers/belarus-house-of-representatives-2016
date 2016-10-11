require 'minitest/autorun'
require_relative '../lib/member_page'
require 'pry'

describe 'MemberPage' do
  it 'creates a page from a url' do
    page = MemberPage.new('http://example.com')
    page.to_h.must_equal({})
  end
end
