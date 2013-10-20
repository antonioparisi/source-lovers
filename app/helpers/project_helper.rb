module ProjectHelper
  def avatar_tag(author)
    a = author.scan(/\b[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}\b/i).first
    a = Digest::SHA1.hexdigest(Time.now.to_s + author) if a.nil?
    "http://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(a)}?s=32&d=identicon&r=PG"
  end
end