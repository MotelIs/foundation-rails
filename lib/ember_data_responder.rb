class EmberDataResponder < ActionController::Responder

  def api_behavior(error = nil)
    raise error unless resourceful?
    raise MissingRenderer.new(format) unless has_renderer?

    if get?
      display resource
    elsif post?
      display resource, status: :created
    elsif put? or patch?
      display resource, status: :ok
    else
      head :no_content
    end
  end

  def resourceful?
    resource.respond_to?("to_#{format}")
  end
end
