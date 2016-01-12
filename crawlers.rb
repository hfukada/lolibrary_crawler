require 'wombat'

def read_page_index(page_url='/')
  Wombat.crawl do
    base_url 'http://lolibrary.org'
    path page_url

    items 'css=div.node-teaser', :iterator do
      name 'css=h2.title'
      link 'css=a @href'
    end
    next_page 'css=li.pager-next a @href'
  end
end


def read_page(page_url)
  Wombat.crawl do
    base_url 'http://lolibrary.org'
    path page_url

    product_title_eng 'css=div.clear-block div.clearfix h1.title'
    product_title_alt 'css=div.field-field-altitle div div'
    product_brand 'css=div.field-field-brand div div', :text
    product_number 'css=div.field-field-productnumber div div', :text
    product_type 'css=div.field-field-items  div div', :text
    product_year 'css=div.field-field-year  div div', :text
    product_pics 'css=div.field-field-pics div div a @href', :list
    p_bust 'css=div.field-field-shopbust div div', :text
    p_waist 'css=div.field-field-shopwaist div div', :text
    p_length 'css=div.field-field-shoplength div div', :text
    p_shoulderwidth 'css=div.field-field-shopshoulderwidth div div', :text
    p_sleevelength 'css=div.field-field-shopsleevelength div div', :text
    product_features 'css=div.field-field-features  div div', :text
    product_extras 'css=div.field-field-featureshide  div div', :text
  end
end
