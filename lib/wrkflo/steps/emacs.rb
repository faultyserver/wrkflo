class EmacsStep < Step
  add_alias :emacs

  def run
    log "Opening an Emacs frame at #{config}"
    `emacsclient -c -a "" -n #{config}`
  end
end
