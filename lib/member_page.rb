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
    noko.xpath('//div[@class="dep_info"]/b[1]/following-sibling::text()').text.tidy
  end
end
