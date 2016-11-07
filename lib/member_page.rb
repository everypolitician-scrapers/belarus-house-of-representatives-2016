require 'scraped_page'

class String
  def tidy
    gsub(/[[:space:]]+/, ' ').strip
  end
end

class MemberPage < ScrapedPage
  field :url do
    url
  end

  field :image do
    noko.at_css('.dep_img img/@src').text.tidy
  end

  field :name do
    noko.at_css('.dep_info h1').text.tidy
  end

  field :id do
    url.split('/').last
  end

  field :area do
    area_and_id[0]
  end

  field :area_id do
    area_and_id[1]
  end

  field :telephone do
    contact_nodes.text
                 .scan(/\(?\+?[0-9]+-?[0-9]+\)\s[0-9]+-[0-9]+-[0-9]+/)
                 .map(&:tidy)
                 .join(';')
  end

  field :website do
    contact_nodes.text
                 .scan(/http:\/\/[a-z]+[.[a-z]+]+/)
                 .map(&:tidy)
                 .join(';')
  end

  private

  def area_and_id
    noko.xpath('//div[@class="dep_info"]/b[1]/following-sibling::text()')
        .text
        .split('№')
        .map(&:tidy)
  end

  def contact_nodes
     noko.xpath('//div[@class="rcb_title" and contains(.,"Контакты")]//following-sibling::*')
  end
end
