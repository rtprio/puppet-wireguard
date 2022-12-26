# frozen_string_literal: true

Facter.add(:wireguard_pubkeys) do
  confine :kernel do |value|
    value == "Linux"
  end

  confine do
    File.directory?('/etc/wireguard/')
  end
  setcode do
    hash = {}
    Dir.glob('/etc/wireguard/*.pub').each do |file|
      filename = file.split('/').last.gsub('.pub', '')
      content = File.read(file)
      hash[filename] = content.chomp
    end
    hash
  end
end

Facter.add(:wireguard_pubkeys) do
  confine :kernel do |value|
    value == "FreeBSD"
  end

  confine do
    File.directory?('/usr/local/etc/wireguard/')
  end
  setcode do
    hash = {}
    Dir.glob('/usr/local/etc/wireguard/*.pub').each do |file|
      filename = file.split('/').last.gsub('.pub', '')
      content = File.read(file)
      hash[filename] = content.chomp
    end
    hash
  end
end
