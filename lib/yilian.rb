require "yilian/version"
require "hash-utils/hash"
require 'uri'
require 'digest/md5'
require 'rest-client'
require 'json'

module Yilian
  class Print
    GATEWAY = 'http://open.10ss.net:8888'

    # options = {
    #   api_key:
    #   partner:
    #   username:
    # }
    def initialize(options)
      @api_key = options[:api_key]
      @partner = options[:partner]
      @username = options[:username]
    end

    # 添加打印机
    def create(opts)
      params ={
        partner: opts[:partner] || @partner,
        machine_code: opts[:machine_code],
        mobilephone: opts[:mobilephone] || '',
        username: opts[:username] || @username,
        printname: opts[:printname],
      }

      params[:sign] = self.sign params, opts[:msign]
      params[:msign] = opts[:msign]

      self.api_request params, 'addprint.php'
    end

    # 删除打印机
    def destroy(opts)
      params ={
        partner: opts[:partner] || @partner,
        machine_code: opts[:machine_code]
      }

      params[:sign] = self.sign params, opts[:msign]
      self.api_request params, 'removeprint.php'
    end

    # 打印内容
    def print(opts)
      params ={
        partner: opts[:partner] || @partner,
        machine_code: opts[:machine_code],
        time: Time.now.to_i
      }

      params[:sign] = self.sign params, opts[:msign]
      params[:content] = opts[:content]

      response = self.api_request params
      JSON.parse response
    end

    def api_request(params, endpoint = '')
      response = RestClient.post "#{GATEWAY}/#{endpoint}", self.params_str(params), content_type: 'json', accept: 'json'
      return response.body if response.code == 200

      false
    end

    def sign(params, msign)
      params = params.ksort
      params_str = params.map{|k, v| "#{k}#{v}"}.join
      Digest::MD5.hexdigest("#{@api_key}#{params_str}#{msign}").upcase
    end

    def params_str(params)
      params.map{|k,v| "#{k}=#{v}"}.join('&')
    end

  end
end