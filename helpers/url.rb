def strip_www url
  url.strip.gsub /^www./, ''
end

def add_www url
  "www.#{strip_www(url)}"
end