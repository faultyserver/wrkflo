class AtomStep < Step
  add_alias :atom

  def run
    log "Opening an Atom Window at #{config["path"]}"
    `atom #{config["path"]}`
  end
end
