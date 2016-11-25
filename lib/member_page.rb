require 'scraped'
require_relative 'contact_info'

class String
  def tidy
    gsub(/[[:space:]]+/, ' ').strip
  end
end

class MemberPage < Scraped::HTML
  field :source do
    url
  end

  field :image do
    noko.at_css('.dep_img img/@src').text.tidy
  end

  field :name do
    name_and_id.split('-')[0..-2]
               .reject { |w| w == 'ru' }
               .map(&:upcase)
               .join(' ')
  end

  field :name_ru do
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

  field :website do
    contact_info.website_addresses.map(&:tidy).join(';')
  end

  field :email do
    contact_info.email_addresses.map(&:tidy).join(';')
  end

  field :term do
    terms[russian_term_name.to_sym]
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
    noko.xpath('//div[@class="tabs"]/span[contains(@class,"fp_tab_selected")]').text
  end

  def contact_info
     @contact_info ||= ContactInfo.new(noko.xpath('//div[@class="rcb_title" and contains(.,"Контакты")]//following-sibling::node()'))
  end

  def terms
    { "Шестой созыв": "6th Convocation" }
  end

  def term_ids
    { "Шестой созыв": 6 }
  end

  def name_and_id
    url.split('/')[-1]
  end
end
