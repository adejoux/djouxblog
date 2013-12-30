class UserMailer < ActionMailer::Base
  default from: "djouxblog@krystalia.fr"

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.user_mailer.posted_comment.subject
  #
  def posted_comment(comment)
    @greeting = "Hi"
    @comment=comment
    
    Role.find_by_name('admin').users.uniq.each do |user|
      mail to: user.email, subject: "comment posted"
    end
  end
end
