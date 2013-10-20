module ProjectHelper
  def author_without_email(author)
    author_without_email = author.match(/([^<]+)/).try(:[], 1).try(:strip)
    author_without_email.present? ? author_without_email : author
  end

  def avatar_tag(author)
    email = author.match(/<([^>]+)/).try(:[], 1)
    email = Digest::SHA1.hexdigest(Time.now.to_s + author) if email.nil?
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(email)}?s=32&d=identicon&r=PG"
  end
end