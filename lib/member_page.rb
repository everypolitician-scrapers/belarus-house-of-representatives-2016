# frozen_string_literal: true
require 'scraped'

class String
  def tidy
    gsub(/[[:space:]]+/, ' ').strip
  end
end

class MemberPage < Scraped::HTML
  decorator Scraped::Response::Decorator::AbsoluteUrls
  # TODO: Add contact info
  field :source do
    url
  end

  field :image do
    noko.at_css('.dep_img img/@src').text.tidy
  end

  field :name do
    name_and_id.split('-')[0..-2]
               .map(&:upcase)
               .join(' ')
  end

  field :name__ru do
    noko.at_css('.dep_info h1').text.tidy
  end

  field :id do
    name_and_id.split('-').last
  end

  field :area do
    area_and_id[0]
  end

  field :area_id do
    area_and_id[1]
  end

  field :term_id do
    term_ids[russian_term_name.to_sym]
  end

  private

  def area_and_id
    noko.xpath('//div[@class="dep_info"]/b[1]/following-sibling::text()')
        .text
        .split('№')
        .map(&:tidy)
  end

  def russian_term_name
    noko.xpath('//div[@class="tabs"]/span[contains(@class,"fp_tab_selected")]')
        .text
  end

  def term_ids
    { "Шестой созыв": 6 }
  end

  def name_and_id
    url.split('/')[-1]
  end
end
