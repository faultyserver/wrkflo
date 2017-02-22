class AtomStep < Step
  add_alias :atom

  def run
    log "Opening an Atom Window at #{config}"
    `atom #{config}`
  end
end
0
