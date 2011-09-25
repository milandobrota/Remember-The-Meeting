module Platform
  def linux?
    RUBY_PLATFORM =~ /linux/
  end
end
