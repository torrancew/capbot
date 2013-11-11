require 'super-config'
require 'capbot/namespace'

class CapBot::Config < SuperConfig
  def self.name
    return 'capbot'
  end # def self.name

  def self.defaults
    return {
      :server   => 'chat.freenode.net',
      :port     => 7000,
      :ssl      => true,
      :name     => name,
      :user     => ENV['USER'],
      :rooms    => ['#cinch-bots'],
      :password => :nil,
      :keywords => {
        :links => {
          'sshkit'  => 'https://github.com/leehambley/sshkit',
          'upgrade' => 'http://www.capistranorb.com/documentation/upgrading/',
        }
      }
    }
  end # def self.defaults

  def self.env_map
    return {
      'CAPBOT_SERVER'   => :server,
      'CAPBOT_PORT'     => :port,
      'CAPBOT_SSL'      => :ssl,
      'CAPBOT_NAME'     => :name,
      'CAPBOT_USER'     => :user,
      'CAPBOT_ROOMS'    => :rooms,
      'CAPBOT_PASSWORD' => :password,
    }
  end # def self.env_map

  def self.load_environment
    env = super
    env.each_setting{ |var, val| env[var] = parse_env_array(val) }
    return env
  end # def self.load_environment

  def self.parse_env_array(value)
    return (value.match(/,/) ? value.split(',') : value)
  end # def self.parse_env_array
end # class CapBot::Config

