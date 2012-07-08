maintainer       'CustomInk'
maintainer_email 'webops@customink.com'
license          'Apache 2.0'
description      'Installs/Configures phantomjs'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.0.1'

recipe 'phantomjs', 'Install phantomjs'

%w(centos ubuntu).each do |os|
  supports os
end
