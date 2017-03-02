class AtomStep < Step
  add_alias :atom

  property :path, required: true, type: String

  def run
    log "Opening an Atom Window at  #{config.path}"
    `atom #{config.path}`
  end
end
