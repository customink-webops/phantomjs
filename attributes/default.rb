default['phantomjs'] = {
  'version' => '1.9.0'
}

case node["platform_family"]
when "debian", "rhel", "fedora"
  default["phantomjs"]["install_method"] = "prebuild"
when "windows"
  default["phantomjs"]["install_method"] = "chocolatey"
end
