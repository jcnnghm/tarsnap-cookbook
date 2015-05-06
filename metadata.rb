name             "tarsnap"
maintainer       "ZephirWorks"
maintainer_email "andrea.campi@zephirworks.com"
license          "Apache 2.0"
description      "Installs/Configures tarsnap"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.1.2"

recipe "tarsnap", "Installs tarsnap"

%w{build-essential git python}.each do |cb|
  depends cb
end

%w{centos freebsd ubuntu debian}.each do |os|
  supports os
end

attribute "tarsnap",
  :display_name => "tarsnap",
  :description => "Hash of tarsnap attributes",
  :type => "hash"

attribute "tarsnap/cachedir",
  :display_name => "tarsnap cachedir",
  :description => "Path to the tarsnap cache dir",
  :default => "/usr/local/tarsnap-cache"

attribute "tarsnap/conf_dir",
  :display_name => "tarsnap config dir",
  :description => "Path to the tarsnap config dir",
  :default => "/etc"

attribute "tarsnap/private_key",
  :display_name => "tarsnap private key",
  :description => "Path to the tarsnap private key file",
  :default => "/etc/tarsnap.key"

attribute "tarsnap/maxbw_rate",
  :display_name => "tarsnap max bandwidth rate",
  :description => "Limit download and upload bandwidth to bytespersecond",
  :default => "Not Set"

attribute "tarsnapper/retention",
  :display_name => "tarsnapper retention policy",
  :description => "Retention policy of tarsnap backups",
  :default => "1d 7d 30d 3650d"

attribute "tarsnapper/jobs",
  :display_name => "tarsnapper backup jobs",
  :description => "Backup jobs tarsnapper runs",
  :default => '{"base" => {"sources" => ["/etc"]}}'

attribute "tarsnapper/cron/setup",
  :display_name => "tarsnapper cron enabled switch",
  :description => "tarsnapper cron creation policy",
  :default => "true"

{"minute" => "30", "hour" => "3", "day" => "Unset (Defaults to *)", "month" => "Unset (Defaults to *)", "weekday" => "Unset (Defaults to *)"}.each {|time, default|
  attribute "tarsnapper/cron/#{time}",
    :display_name => "tarsnapper cron #{time} schedule",
    :description => "The #{time} the tarsnapper entry should run",
    :default => default
}
