class ContentMagnetMailer < ApplicationMailer
  default from: "david@everclimb.co"

  def send_magnet(email,name,content_magnet_id)
    @magnet = ContentMagnet.find(content_magnet_id)
    @name = name
    mail(to: email, subject: "#{@magnet.title}")
  end
end
