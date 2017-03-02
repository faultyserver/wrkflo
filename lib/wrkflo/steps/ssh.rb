class SSHStep < Step
  add_alias :ssh

  property :host,       required: true, type: String
  property :directory,  required: true, type: String

  def run
    log "SSHing into  #{config.host}  at  #{config.directory}"

    ssh_command = "ssh -t #{config.host} \\\"#{config.directory}; bash --login\\\""
    `osascript -e 'tell application "Terminal" to activate' -e 'tell application "System Events" to tell process "Terminal" to keystroke "t" using command down' -e 'tell application "Terminal" to do script "#{ssh_command}" in selected tab of the front window'`
  end
end
