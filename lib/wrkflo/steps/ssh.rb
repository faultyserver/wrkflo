class SSHStep < Step
  add_alias :ssh

  def run
    log "SSHing into  #{config['host']}  at  #{config['directory']}"

    ssh_command = "ssh -t #{config['host']} \\\"#{config['directory']}; bash --login\\\""
    `osascript -e 'tell application "Terminal" to activate' -e 'tell application "Terminal" to set ssh_window to do script "#{ssh_command}"'`
  end
end
