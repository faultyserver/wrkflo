class SublimeStep < Step
  add_alias :sublime
  add_alias :subl

  property :path, required: true, type: String

  def run
    log "Opening a Sublime Window at  #{config.path}"
    `subl -n #{config.path}`
  end
end
