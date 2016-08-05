require "bundler/setup"
require "yilian"

config = {
  api_key: '',
  partner: '',
  username: '',
  machine_code: '',
  msign: '',
  printname: '',
}

print =  Yilian::Print.new(config)

opts ={
  machine_code: config[:machine_code],
  printname: config[:printname],
  msign: config[:msign]
}

# p print.create(opts)

# opts ={
#   machine_code: config[:machine_code],
#   msign: config[:msign]
# }

# p print.destroy(opts)

opts ={
  machine_code: config[:machine_code],
  msign: config[:msign],
  content: '打印测试....'
}

p print.print(opts)
