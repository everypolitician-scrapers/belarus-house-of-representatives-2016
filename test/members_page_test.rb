# frozen_string_literal: true

require_relative './test_helper'
require_relative '../lib/members_page'

describe MembersPage do
  around { |test| VCR.use_cassette(File.basename(url), &test) }

  subject do
    MembersPage.new(response: Scraped::Request.new(url: url).response)
  end

  let(:url) { 'http://house.gov.by/ru/sozyvy-ru/view/shestoj-sozyv-15' }

  it 'should contain the expected number of urls' do
    subject.member_urls.count.must_equal 110
  end

  it 'should contain the expected url' do
    subject.member_urls.first.must_equal 'http://house.gov.by/ru/deputies-ru/view/adamenko-evgenij-570/'
  end
end
