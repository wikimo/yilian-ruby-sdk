require "yilian/version"
require "hash-utils/hash"
require 'uri'
require 'digest/md5'
require 'rest-client'

module Yilian
  class Print
    GATEWAY = 'http://open.10ss.net:8888'

    def initialize(options)
      @api_key = options[:api_key]
    end

    def sign(params, msign)
      params = params.ksort
      params_str = params.map{|k, v| "#{k}#{v}"}.join
      Digest::MD5.hexdigest("#{@api_key}#{params_str}#{msign}").upcase
    end

    def params_str(params)
      params.map{|k,v| "#{k}=#{v}"}.join('&')
    end
    
    # 添加打印机
    def create(opts)
      params ={
        partner: opts[:partner],
        machine_code: opts[:machine_code],
        mobilephone: opts[:mobilephone],
        username: opts[:username],
        printname: opts[:printname],
      }

      params[:sign] = self.sign params, opts[:msign]
      params[:msign] = opts[:msign]
      params_str = self.params_str params

      RestClient.post "#{GATEWAY}/addprint.php", params_str, content_type: 'json'
    end

    # 删除打印机
    def destroy(opts)
      params ={
        partner: opts[:partner],
        machine_code: opts[:machine_code]
      }

      params[:sign] = self.sign params, opts[:msign]
      params_str = self.params_str params

      RestClient.post "#{GATEWAY}/removeprint.php", params_str, content_type: 'json'
    end

    # 打印内容
    def print(opts)
      params ={
        partner: opts[:partner],
        machine_code: opts[:machine_code],
        time: Time.now.to_i
      }

      params[:sign] = self.sign params, opts[:msign]
      params[:content] = opts[:content]
      params_str = self.params_str params

      RestClient.post "#{GATEWAY}", params_str, content_type: 'json', accept: 'json'
    end
  end
end