require 'pp'
require 'json'

require_relative './crawlers'

def clean_single(item, key)
  if not item[key].nil?
    item[key] = item[key].sub(/(\w| )+:/, '').gsub(/\t|\n|\302\240/, " ").strip
  end
end

def clean_item_info(item)
  clean_single(item, 'product_brand')
  clean_single(item, 'product_number')
  clean_single(item, 'product_type')
  clean_single(item, 'product_year')
  clean_single(item, 'p_bust')
  clean_single(item, 'p_waist')
  clean_single(item, 'p_length')
  clean_single(item, 'p_shoulderwidth')
  clean_single(item, 'p_sleevelength')
  clean_single(item, 'product_features')
  clean_single(item, 'product_extras')
  return item
end

page_index = '/'
page_counter = 1
while not page_index.nil? do
#while not page_index == '/node?page=1'
  data = read_page_index page_index
  if page_index == '/'
    data['items'].shift
  end

  cleaned_page_data = data['items'].map{|item|
    item_data = read_page item['link']
    clean_item_info item_data
  }
  File.open("lolibrary_pages/page_#{page_counter}.json", "w") do |f|
    f.write(cleaned_page_data.to_json)
  end
  page_counter += 1
  puts page_counter
  page_index = data['next_page']
  sleep 1
end
