# frozen_string_literal: true

require 'scraped'

class MemberPage < Scraped::HTML
  decorator Scraped::Response::Decorator::AbsoluteUrls
  # TODO: Add contact info
  # Issue:
  # https://github.com/everypolitician/everypolitician-data/issues/22638
  field :id do
    url_slug.split('-').last
  end

  field :name do
    url_slug.split('-')[0..-2]
            .map(&:upcase)
            .join(' ')
  end

  field :name__ru do
    noko.at_css('.dep_info h1').text.tidy
  end

  field :area do
    area_and_id[0]
  end

  field :area_id do
    area_and_id[1]
  end

  field :image do
    noko.at_css('.dep_img img/@src').text.tidy
  end

  field :source do
    url
  end

  private

  def area_and_id
    noko.xpath('//div[@class="dep_info"]/b[1]/following-sibling::text()')
        .text
        .split('№')
        .map(&:tidy)
  end

  def url_slug
    url.split('/').last
  end
end
