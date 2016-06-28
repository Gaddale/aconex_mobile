Given(/^\'(#{STRING})\' sends a mail with \'(#{STRING})\'$/) do |user, mail_params|
  visit_mobile NewMailPage, get_instance_var(user), get_instance_var(user).project do |page|
    @edit_field_params = get_instance_var(mail_params)
    if @edit_field_params.has_key? 'To'
      @edit_field_params = insert_field('To', @edit_field_params)
    end
    page.compose_mail(@edit_field_params)
    @subject = page.send_mail
    page.logout
  end
end

Then(/^\'(#{STRING})\' should receive the mail with \'(#{STRING})\'$/) do |user, mail_params|
  visit_mobile MailInboxPage, get_instance_var(user), get_instance_var(user).project do |page|
    page.search_mail(@subject).open_mail
    page.verify_received_mail(get_instance_var(mail_params))
    page.logout
  end

end

def insert_field(to_cc, params)
  mail_to_cc_bcc_fields = []
  case to_cc.downcase
    when 'to'
      params['To'].split(',').each { |to_recip| mail_to_cc_bcc_fields.push(get_instance_var(to_recip.strip).fullname)}
      @mail_to_fields = {'To' =>(mail_to_cc_bcc_fields.map(&:inspect).join(', ')).gsub(/"/, '')}
      params.update @mail_to_fields
   end
end

