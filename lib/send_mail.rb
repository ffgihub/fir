require 'rubygems'
require 'rest-client'

class SendMail

  def self.send_mail(to,subject,html)
    response = RestClient.post "http://api.sendcloud.net/apiv2/mail/send",
    #使用api_user和api_key进行验证
    :apiUser => 'sc_fzhet7_test_QV0KKv', 
    #点击左侧菜单API User,点击生成新的API_KEY
    :apiKey => 'aa0396550d031f7e4e8a0410f404035f', 
    #发信人，用正确邮件地址替代
    :from => "sendcloud@fC52gNYA2441s6KLOXr7xmw0w1RKoZEE.sendcloud.org", 
    :fromName => "SendCloud",
    #收件人地址，用正确邮件地址替代，多个地址用';'分隔
    :to => "#{to}",
    :subject => "#{subject}",
    :html => "#{html}"
    return response
  end
end

