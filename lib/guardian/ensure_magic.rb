#Support for ensure_{blah}! methods

module EnsureMagic

  def method_missing(method, *args, &block)
    if method.to_s =~ /^ensure_(.*)\!$/
      can_method = :"#{Regexp.last_match[1]}?"

      if respond_to?(can_method)
        raise Foundation::InvalidAccess.new("#{can_method} failed") unless send(can_method, *args, &block)
        return
      end
    end

    super.method_missing(method, *args, &block)
  end

  def ensure_can_see!(obj)
    raise Foundation::InvalidAccess.new("Can't see #{obj}") unless can_see?(obj)
  end
end

# line 5: takes the method, any*args, and a callback block
# &block: allows you to specify a callback to pass to a method in 1 of 2 ways:
# 1: capturing it by specifying a final argument prefixed with &, or
# 2: by using the yield keyword

# line 6: regex for checking that the method is following proper format
# returns the position where the match starts or nil if there is no match

# line 7: saves can_method variable to the last matching Regex or nil

# line 9: respond_to is used to determine if an object responds to a method
# line 10: if it does, raise a new InvalidAccess error (through CORS I think)
# unless the method arguments can be sent?

# line 15: calling super to recursively call the method.

# line 19: for ensure_can_see!(obj) method raise an error unless object can be seen.
