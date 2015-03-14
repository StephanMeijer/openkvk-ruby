module OpenKVK
  def version
    major = 0
    minor = 0
    tiny  = 2

    [major, minor, tiny].join('.')
  end

  module_function :version
end
