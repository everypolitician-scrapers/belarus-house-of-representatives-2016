# frozen_string_literal: true
require 'scraped'

class AbsoluteLinks < Scraped::Response::Decorator
  def body
    doc = Nokogiri::HTML(super)
    doc.css('a').each do |link|
      link[:href] = URI.join(url, link[:href]).to_s
    end
    doc.to_s
  end
end
