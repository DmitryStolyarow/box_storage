class ItemReturnMailer < ActionMailer::Base
  layout 'layouts/mailer'
  default from: 'box_storage@example.com'

  def email(user, line_item, return_at)
    @user = user
    @line_item = line_item
    @return_at = return_at
    mail(to: user.email, subject: 'Request for item return') do |format|
      format.html(content_transfer_encoding: 'quoted-printable')
    end
  end
end
