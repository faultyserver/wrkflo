class EmacsStep < Step
  add_alias :emacs

  property :path, required: true

  def run
    log "Opening an Emacs frame at #{config.path}"
    `emacsclient -c -a "" -n #{config.path}`
  end
end
