require 'scraped_page'

class String
  def tidy
    gsub(/[[:space:]]+/, ' ').strip
  end
end

class MemberPage < ScrapedPage
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

  field :telephone do
    # The markdown within the target div is non-semantic and inconsistent
    # from page to page. Splitting by preceding characters does not work
    # because preceding characters vary.
    # Any phone number in one of the two telephone formats on the site
    # ( (x-xxxx) xx-xx-xx & (+xxxxx) xxx-xx-xx ) will be matched by the regex.
    # Multiple numbers will be joined by a semi-colon.
    contact_nodes.text
                 .scan(/\(?\+?[0-9]+-?[0-9]+\)\s[0-9]+-[0-9]+-[0-9]+/)
                 .map(&:tidy)
                 .join(';')
  end

  field :website do
    # The markdown within the target div is non-semantic and inconsistent
    # from page to page. Splitting by preceding characters does not work
    # because preceding characters vary.
    # The regex makes the naive assumption that any string begining with
    # http:// followed by a sequence of dots and letters is a web address.
    contact_nodes.text
                 .scan(/http:\/\/(?:\w|\d)+[\.(?:\w|\d)+]+/)
                 .map(&:tidy)
                 .join(';')
  end

  field :email do
    contact_nodes.text
                 .downcase
                 .scan(/[a-z]+.?[a-z]+@[a-z]+(?:\.[a-z]+)+/)
                 .map(&:tidy)
                 .join(';')
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

  def contact_nodes
     noko.xpath('//div[@class="rcb_title" and contains(.,"Контакты")]//following-sibling::*')
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
