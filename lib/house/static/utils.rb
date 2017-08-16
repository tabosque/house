require 'open3'
require 'open-uri'
require 'nokogiri'
require 'pry'

def download(url, root_url)
  # Download target page
  wget(url)

  # Parse target page
  doc = parse(url)

  # Download OGP image
  ogp_image_path = meta_content_url(doc, '//meta[@property="og:image"]')
  wget(root_url + ogp_image_path) unless ogp_image_path.nil?

  # Download Twitter card image
  twitter_card_path = meta_content_url(doc, '//meta[@name="twitter:image:src"]')
  wget(root_url + twitter_card_path) unless twitter_card_path.nil?
end

def meta_content_url(document, xpath)
  target_node = document.xpath(xpath)
  if target_node.any?
    target_node.attribute('content').value
  else
    nil
  end
end

def wget(url)
  Open3.capture3("wget -p -k -E #{url}")
end

def parse(url)
  charset = nil
  html = open(url) do |f|
    charset = f.charset
    f.read
  end
  Nokogiri::HTML.parse(html, nil, charset)
end