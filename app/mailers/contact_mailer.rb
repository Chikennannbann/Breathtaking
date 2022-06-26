class ContactMailer < ApplicationMailer
  def send_notification(member, event)
    @group = event[:group]
    @title = event[:title]
    @body = event[:body]

    @mail = ContactMailer.new
    mail(
      from: ENV['MAIL_ADDRESS'],
      to: member.email,
      subject: 'BREATHTAKING-絶景- グループからの通知'
    )
  end

  def self.send_notifications_to_group(event)
    group = event[:group]
    group.end_users.each do |member|
      ContactMailer.send_notification(member, event).deliver_now
    end
  end
end
